class DimensionData < ActiveRecord::Base
  belongs_to :school

  DEFAULT_PARAMS = {
    :minimum_value    => 0,
    :maximum_value    => 5,
    :margins          => 5,
    :top_margin       => 0,
    :legend_font_size => 16,
    :legend_box_size  => 14,
    :title_margin     => 50,
    :title_font_size  => 19,
    :bar_spacing      => 1,
    :marker_count     => 5,
    :legend_margin    => 52,
    :sort             => false,
    :top_label_size   => 10
  }

  COLORS = ['#3D2D84', '#FFC540']

  def self.get_data
      ServiceLevel.all.each do |sl|
        previous_avaliations = GeneralReportData.all(:conditions => "service_level_id = #{sl.id} and indicator_id is not null", 
          :order => "dimension_id ASC, indicator_id + 0 ASC")
        previous_avaliations.each do |p|
          puts p.inspect
          dimension = Dimension.first(:conditions => "id = #{p.dimension_id}")
          indicator = Indicator.first(:conditions => "id = #{p.indicator_id}")
          DimensionData.create(:dimension_number => dimension.number, :indicator_number => indicator.number, 
            :year => p.year, :value => p.media, :service_level_id => sl.id)
        end

        general_data = GeneralData.find_by_sql("
          SELECT *, ROUND(AVG(media),2) as calculated_media FROM general_data 
          WHERE media >= 0 and media <= 5 AND service_level_id = #{sl.id}
          GROUP BY indicator_number, dimension_number
          ORDER BY dimension_number ASC, indicator_number ASC")
        general_data.each do |r|
          DimensionData.create(:dimension_number => r.dimension_number, :indicator_number => "#{r.dimension_number}.#{r.indicator_number}", 
            :year => 2011, :value => r.calculated_media.to_s[0..2], :service_level_id => sl.id)
        end
      end
  end

  def self.generate_dimensions_graphic(school_id, service_level_id)
    dimension_data = DimensionData.find_by_sql("
      SELECT *, ROUND(AVG(value),1) as calculated_media, indicator_number as inu FROM dimension_data
      WHERE school_id = #{school_id} AND service_level_id = #{service_level_id}
      GROUP BY year, dimension_number
      ORDER BY year, dimension_number")
    years, data_per_years = get_years_and_data_per_year(dimension_data)
    
    labels = get_labels_for_dimensions_graphic(data_per_years[years.last].collect(&:dimension_number))

    values = Hash.new
    years.each do |y|
      values[y] = get_values_for_dimensions_graphic(labels, data_per_years[y])
    end

    g = Gruff::Bar.new("900x500")
    g.title = ' '

    i_color = 0
    years.each do |y|
      if y == 2011
        i_color = 1
      else
        i_color = 0
      end
      g.data(y.to_s, values[y], COLORS[i_color])
    end
    g.data(" ", Array.new(values[years.last].count, 0), "#fff")

    
    g.theme = {
            :marker_color => 'white',
            :background_colors => 'white'
          }

    DEFAULT_PARAMS.each {|k, v| g.instance_variable_set("@#{k}", v)}
    
    label_number = 0
    labels.each do |l|
      g.labels[label_number] = l
      label_number += 1
    end
#    g.labels[labels.length] = "Geral"

    
    g.write("#{Rails.root.to_s}/tmp/#{school_id}_#{service_level_id}_dimensions_graphic.jpg")
  end

  def self.generate_graphic_per_dimension(school_id, service_level_id, dimension_number)
    dimension_data = DimensionData.all(:conditions => "school_id = #{school_id} AND service_level_id = #{service_level_id}
      AND dimension_number = #{dimension_number}", :order => 'YEAR ASC')
    years, data_per_years = get_years_and_data_per_year(dimension_data)

    labels = get_labels(data_per_years[years.last].collect(&:indicator_number), dimension_number)

    puts data_per_years[years.last].collect(&:indicator_number).inspect
    values = Hash.new
    years.each do |y|
      values[y] = get_values(labels, data_per_years[y])
    end

    g = Gruff::Bar.new("900x500")
    g.title = get_title(service_level_id, dimension_number)

    i_color = 0
    years.each do |y|
      if y == 2011
        i_color = 1
      else
        i_color = 0
      end
      g.data(y.to_s, values[y], COLORS[i_color])
    end

    g.data(" ", Array.new(values[years.last].count, 0), "#fff")

    
    g.theme = {
            :marker_color => 'white',
            :background_colors => 'white'
          }

    DEFAULT_PARAMS.each {|k, v| g.instance_variable_set("@#{k}", v)}
    
    label_number = 0
    labels.each do |l|

      if service_level_id == 3
        special_indicators = ['1.4', '3.9' , '4.5']
      elsif service_level_id == 5
        special_indicators = ['1.4', '4.5']
      else
        special_indicators = ['1.4', '3.10' , '4.5']
      end

      if (special_indicators.include?(l))
        l = "#{l}*"
      end
      g.labels[label_number] = l
      label_number += 1
    end
#    g.labels[labels.length] = "Geral"

    
    g.write("#{Rails.root.to_s}/tmp/#{school_id}_#{service_level_id}_#{dimension_number}_dimension_graphic.jpg")

  end

  def self.get_years_and_data_per_year(data)
    years = []
    actual_year = data.first.year
    data.each do |d|
      if actual_year != d.year
        years << actual_year 
      end
      actual_year = d.year
    end
    years << actual_year 
    new_data = Hash.new
    years.each do |y|
      new_data[y] ||= []
      data.each do |d|
        new_data[y] << d if d.year == y
      end 
    end
    return years, new_data
  end

  def self.get_years_and_data_per_year_geral(data)
    new_data = []
    data.each do |d|
      new_data << d
    end 
    new_data
  end

  def self.get_labels(indicators, dimension_number)
    labels = []
    indicators.count.times do |i|
      labels << "#{dimension_number}.#{i+1}"
    end
    labels
  end

  def self.get_values(labels, data)
    values = []
    labels.each do |l|
      data.each do |d|
        values << d.value if d.inu.to_s == l
      end
    end
    values
  end

  def self.get_title(service_level_id, dimension_number)
    service_level = ServiceLevel.find(service_level_id)
    dimension = Dimension.first(:conditions => "number = #{dimension_number} AND service_level_id = #{service_level.id}")
    title = "Dimensão #{dimension_number}. #{dimension.name}"
    new_title = ''
    control_title = 0
    if title.length > 74
      title.split(' ').each do |t|
        if control_title > 70
          new_title << "\n#{t}"
          control_title = 0
          control_title  += "\n#{t}".length
        else
          new_title << " #{t}"
          control_title  += " #{t}".length
        end
      end
      return new_title
    else
      return title
    end
  end

  def self.get_labels_for_dimensions_graphic(dimensions)
    labels = []
    dimensions.count.times do |i|
      labels << "#{i+1}"
    end
    labels
  end

  def self.get_values_for_dimensions_graphic(labels, data)
    values = []
    labels.each do |l|
      data.each do |d|
        values << d.calculated_media.to_s[0..2].to_f if d.dimension_number.to_s == l
      end
    end
    values
  end

  def self.generate_dimensions_graphic_geral(service_level_id)
    dimension_data_2010 = DimensionData.find_by_sql("
      SELECT *, ROUND(AVG(media),1) as calculated_media, d.number as dimension_number 
      FROM general_report_data g
      INNER JOIN dimensions d ON g.dimension_id = d.id
      WHERE g.service_level_id = #{service_level_id}
      AND YEAR = 2010
      AND data_type = 1
      AND media > 0
      GROUP BY dimension_number
      ORDER BY dimension_number")
    dimension_data = DimensionsAverageGeral.find_by_sql("
      SELECT *, ROUND(AVG(value),2) as calculated_media FROM dimensions_average_geral g
      WHERE service_level_id = #{service_level_id}
      GROUP BY dimension_number
      ORDER BY dimension_number")

    years = [2010, 2011]
    data_per_years = Hash.new
    data_per_years[2010] = get_years_and_data_per_year_geral(dimension_data_2010)
    data_per_years[2011] = get_years_and_data_per_year_geral(dimension_data)

    labels = get_labels_for_dimensions_graphic(data_per_years[2011].collect(&:dimension_number))

    values = Hash.new
    years.each do |y|
      values[y] = get_values_for_dimensions_graphic(labels, data_per_years[y])
    end

    g = Gruff::Bar.new("900x500")
    g.title = ' '

    i_color = 0
    years.each do |y|
      if y == 2011
        i_color = 1
      else
        i_color = 0
      end
      g.data(y.to_s, values[y], COLORS[i_color])
    end
    g.data(" ", Array.new(values[years.last].count, 0), "#fff")

    
    g.theme = {
            :marker_color => 'white',
            :background_colors => 'white'
          }

    DEFAULT_PARAMS.each {|k, v| g.instance_variable_set("@#{k}", v)}
    
    label_number = 0
    labels.each do |l|
      g.labels[label_number] = l
      label_number += 1
    end
#    g.labels[labels.length] = "Geral"

    
    g.write("#{Rails.root.to_s}/tmp/#{service_level_id}_dimensions_graphic_geral.jpg")
  end

  def self.generate_graphic_per_dimension_geral( service_level_id, dimension_number)
    dimension_data_2010 = DimensionData.find_by_sql("
      SELECT *, ROUND(AVG(media),1) as value, CONCAT(d.number, '.' ,i.number) as inu 
      FROM general_report_data g
      INNER JOIN dimensions d ON g.dimension_id = d.id
      INNER JOIN indicators i ON g.indicator_id = i.id
      WHERE g.service_level_id = #{service_level_id}
      AND YEAR = 2010
      AND d.number = #{dimension_number}
      AND data_type = 1
      AND media > 0
      GROUP BY i.number")
    dimension_data = IndicatorsDataGeral.find_by_sql("
      SELECT ROUND(AVG(value),1) as value, CONCAT(dimension_number, '.' ,indicator_number) as inu 
      FROM indicators_data_geral
      WHERE service_level_id = #{service_level_id} AND
      dimension_number = #{dimension_number}
      GROUP BY indicator_number
      ")

    years = [2010, 2011]
    data_per_years = Hash.new
    data_per_years[2010] = get_years_and_data_per_year_geral(dimension_data_2010)
    data_per_years[2011] = get_years_and_data_per_year_geral(dimension_data)
    

    labels = get_labels(data_per_years[2011].collect(&:inu), dimension_number)

    puts '-' * 100
    puts data_per_years[years.last].inspect
    puts '-' * 100
    values = Hash.new
    years.each do |y|
      values[y] = get_values(labels, data_per_years[y])
    end

    g = Gruff::Bar.new("900x500")
    g.title = get_title(service_level_id, dimension_number)

    i_color = 0
    years.each do |y|
      if y == 2011
        i_color = 1
      else
        i_color = 0
      end
      g.data(y.to_s, values[y], COLORS[i_color])
    end

    g.data(" ", Array.new(values[years.last].count, 0), "#fff")

    
    g.theme = {
            :marker_color => 'white',
            :background_colors => 'white'
          }

    DEFAULT_PARAMS.each {|k, v| g.instance_variable_set("@#{k}", v)}
    
    label_number = 0
    labels.each do |l|

      if service_level_id == 3
        special_indicators = ['1.4', '3.9' , '4.5']
      elsif service_level_id == 5
        special_indicators = ['1.4', '4.5']
      else
        special_indicators = ['1.4', '3.10' , '4.5']
      end

      if (special_indicators.include?(l))
        l = "#{l}*"
      end
      g.labels[label_number] = l
      label_number += 1
    end
#    g.labels[labels.length] = "Geral"

    
    g.write("#{Rails.root.to_s}/tmp/#{service_level_id}_#{dimension_number}_dimension_graphic_geral.jpg")

  end

end
