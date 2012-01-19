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
    School.all.each do |s|
      s.service_levels.each do |sl|
        previous_avaliations = PreviousAvaliation.all(:conditions => "school_id = #{s.id} AND service_level_id = #{sl.id}", 
          :order => "dimension_id ASC, indicator_number + 0 ASC")
        previous_avaliations.each do |p|
          dimension = Dimension.first(:conditions => "number = #{p.dimension_id} AND service_level_id = #{sl.id}")
          DimensionData.create(:dimension_number => dimension.number, :indicator_number => p.indicator_number, 
            :year => p.year, :value => p.media, :school_id => s.id, :service_level_id => sl.id)
        end

        report_data = ReportData.find_by_sql("
          SELECT *, ROUND(AVG(media),1) as calculated_media FROM report_data 
          WHERE school_id = #{s.id} AND media >= 0 and media <= 5 AND service_level_id = #{sl.id}
          GROUP BY indicator_id
          ORDER BY dimension_id ASC, indicator_id ASC")
        report_data.each do |r|
          dimension = Dimension.find(r.dimension_id)
          indicator = Indicator.find(r.indicator.id)
          DimensionData.create(:dimension_number => dimension.number, :indicator_number => "#{dimension.number}.#{indicator.number}", 
            :year => 2011, :value => r.calculated_media, :school_id => s.id, :service_level_id => sl.id)
        end
      end
    end
  end

  def self.generate_dimensions_graphic(school_id, service_level_id)
    dimension_data = DimensionData.find_by_sql("
      SELECT *, ROUND(AVG(value),1) as calculated_media FROM dimension_data
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
        values << d.value if d.indicator_number.to_s == l
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
        values << d.calculated_media if d.dimension_number.to_s == l
      end
    end
    values
  end

end
