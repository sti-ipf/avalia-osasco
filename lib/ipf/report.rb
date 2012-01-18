module IPF
  class Report

    TEMPLATE_DIRECTORY= File.expand_path "#{RAILS_ROOT}/lib/templates"
    TEMP_DIRECTORY = File.expand_path "#{RAILS_ROOT}/tmp"
    PUBLIC_DIRECTORY = File.expand_path "#{RAILS_ROOT}/public"

    def generate_graphics(school_id, service_level_id)
      dimensions = Dimension.all(:conditions => "service_level_id = #{service_level_id}")
      DimensionData.generate_dimensions_graphic(school_id, service_level_id)
      dimensions.each do |d|
        puts "GERANDO GRÁFICOS PARA A DIMENSAO #{d.number}"
        DimensionData.generate_graphic_per_dimension(school_id, service_level_id, d.number)
        ReportData.dimension_graphic(school_id, service_level_id, d.number)
        indicators = Indicator.all(:conditions => "dimension_id = #{d.id}", :order => "number ASC").collect(&:number)
        indicators.each do |i|
          ReportData.indicator_graphic(school_id, service_level_id, d.number, i)
        end
      end
    end

    def generate_question_tables(school_id, service_level_id)
      dimensions = Dimension.all(:conditions => "service_level_id = #{service_level_id}")
      dimensions.each do |d|
        puts "GERANDO TABELA COM QUESTOES PARA A DIMENSAO #{d.number}"
        IPF::TableGenerator.generate_question_table(school_id, service_level_id, d.number)
      end
    end

    def generate_practice_tables(school_id, service_level_id)
      dimensions = Dimension.all(:conditions => "service_level_id = #{service_level_id}")
      dimensions.each do |d|
        puts "GERANDO TABELA DE PRATICAS PARA A DIMENSAO #{d.number}"
        IPF::TableGenerator.generate_practices_table(school_id, service_level_id, d.number)
      end
    end

    def generate_index_table(school_id, service_level_id)
      IPF::TableGenerator.generate_index_table(school_id, service_level_id)
    end

    def generate_file(school_id, service_level_id)
      @type = ServiceLevel.find(service_level_id).name

      case @type
        when "CRECHE"
          dimensions_total = 10
        when "EMEI"
          dimensions_total = 10
        when "EMEF"
          dimensions_total = 11
        when "EJA"
          dimensions_total = 9
        when "BURJATO"
          dimensions_total = 11
        when "CRECHE CONVENIADA"
          dimensions_total = 10
          @type = "CONVENIADA"
      end

      school = School.find(school_id)

      doc = RGhost::Document.new
      doc.define_tags do
        tag :font1, :name => 'HelveticaBold', :size => 12, :color => '#000000'
        tag :font2, :name => 'Helvetica', :size => 12, :color => '#000000'
        tag :font3, :name => 'CalibriBold', :size => 13, :color => '#535353'
        tag :index, :name => 'Helvetica', :size => 8, :color => '#000000'
        tag :indexwhite, :name => 'Helvetica', :size => 8, :color => '#FFFFFF'
      end

      school_name = "#{school.report_name} (#{@type})"
      
      title = []
      tmp_title = ''
      school_name = school_name.split(' ')
      t_i = 0
      school_name.each do |s|
        title[t_i] ||= ''
        if title[t_i].length <= 40
          title[t_i] << "#{s} "
        else
          t_i += 1
          title[t_i] ||= ''
          title[t_i] << "#{s} "
        end

      end

      school_name = "#{school.report_name} (#{@type})"

      ['capa', 'expediente'].each do |s|
        doc.image File.join(TEMPLATE_DIRECTORY, "#{s}.eps")
        if s == 'capa'
          t_y = [10.7, 10, 9.3]
          t_i = 0
          title.each do |t|
            doc.moveto :x => 7.6, :y => t_y[t_i]
            doc.show t, :with => :font3, :align => :show_left
            t_i += 1
          end
        end
        doc.next_page
      end

      if @type == "EMEF"
        initial_pages_total = 10
      elsif @type == "BURJATO"
        initial_pages_total = 9
      elsif @type == "CONVENIADA"
        initial_pages_total = 10
      else
        initial_pages_total = 10
      end

      

      initial_pages_total.times do |i|
        doc.image next_page_file(doc)
        if i == 0
          doc.moveto :x => 10.5, :y => 25.4
          doc.show "#{school_name}", :with => :font1, :align => :show_center
        end
        doc.next_page if i != (initial_pages_total-1)
      end

      segment_participation = Answer.find_by_sql("
        SELECT s.name, ROUND(AVG(quantity_of_people),1) AS calculated_media FROM answers a 
          INNER JOIN segments s on a.segment_id = s.id
          WHERE a.school_id = #{school.id}
          AND s.id IN (SELECT id FROM segments WHERE service_level_id = #{service_level_id})
          GROUP BY s.name
      ")

      y_points = [23.4, 22.7, 22, 21.3, 20.6]
      y_number = 0

      segment_participation.each do |p|
        doc.moveto :x => 6.1, :y => y_points[y_number]
        doc.show p.name, :with => :font2, :align => :show_center 
        doc.moveto :x => 14.5, :y => y_points[y_number]
        doc.show p.calculated_media.to_i, :with => :font2, :align => :show_center 
        y_number += 1
      end
      
      doc.next_page 

      if (@type != "EJA" && @type != "CONVENIADA")
        

        doc.image next_page_file(doc)  
        file = File.join(TEMP_DIRECTORY,"#{school_id}_#{service_level_id}_dimensions_graphic.jpg")
        puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

        doc.image file, :x => 1.6, :y => 15, :zoom => 55
        doc.showpage
        doc.image next_page_file(doc)
        y = 17
        (1..dimensions_total).each do |i|      
          file = File.join(TEMP_DIRECTORY,"#{school_id}_#{service_level_id}_#{i}_dimension_graphic.jpg")
          puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

          doc.image file, :x => 1.6, :y => y, :zoom => 50

          if [4, 6, 8].include?(i)
            y = 5.5
          else
            y = 19.2
            doc.showpage 
            doc.image next_page_file(doc) if i != dimensions_total
          end
        end
      end

      dimension_graphic_y_points = [0, 10, 12.5, 12.5, 12, 11, 12.5, 12.5, 11, 13.5, 12.5, 12.5]

      (1..dimensions_total).each do |i|

        dimension = Dimension.first(:conditions => "service_level_id = #{service_level_id} AND number = #{i}")
        doc.image next_page_file(doc)
        file = File.join(TEMP_DIRECTORY,"#{school_id}_#{service_level_id}_#{i}_ue_dimension_graphic.jpg")
        puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

        doc.image file, :x => 1.6, :y => dimension_graphic_y_points[i], :zoom => 55
        doc.showpage

        
        doc.image next_page_file(doc)
        graphics = 0
        indicators = Indicator.all(:conditions => "dimension_id = #{dimension.id} and id NOT IN (262, 267, 281, 285)", :order => "number ASC").collect(&:number)
        count = 0


        indicators.each do |indicator|
          case graphics
            when 0
              y = 20.4
            when 1
              y = 14
            when 2
              y = 7.5
            when 3
              y = 1
          end
          
          
          file = File.join(TEMP_DIRECTORY,"#{school_id}_#{service_level_id}_#{i}_#{indicator}_ue_indicator_graphic.jpg")
          puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

          doc.image file, :x => 3, :y => y, :zoom => 45

          graphics += 1
          count += 1

          if graphics >= 4
            add_index(doc) if count > 4
            doc.showpage
            graphics = 0
          end

        end
        
        if graphics != 0 && indicators.count > 4
          add_index(doc)
          doc.showpage
        end

        if graphics < 4 && indicators.count < 4
          doc.showpage
        end


        if @type == "EJA" || @type == "CONVENIADA"
          question_y_points = [0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
        else
          question_y_points = [0, 9, 9, 6, 9, 9, 9, 9, 9, 9, 9, 9]
        end
        
        
        doc.image next_page_file(doc)
        file = File.join(TEMPLATE_DIRECTORY,"#{school_id}_#{service_level_id}_#{i}_questoes.jpg")
        doc.image file, :x => 1.6, :y => question_y_points[i], :zoom => 50
        doc.showpage

        doc.image next_page_file(doc)
        file = File.join(TEMPLATE_DIRECTORY,"#{school_id}_#{service_level_id}_#{i}_praticas.jpg")
        doc.image file, :x => 1.6, :y => 9, :zoom => 50
        doc.next_page 

        doc.image next_page_file(doc)
        doc.next_page 
        
      end

      doc.image next_page_file(doc)
      doc.next_page 

      doc.image next_page_file(doc)
      file = File.join(TEMPLATE_DIRECTORY,"#{school_id}_#{service_level_id}_index.jpg")
      doc.image file, :x => 1.6, :y => 9, :zoom => 50
      doc.next_page 

      doc.image next_page_file(doc)
      
      file_name = school.name.gsub(/[^a-z0-9çâãáàêẽéèîĩíìõôóòũûúù' ']+/i, '').gsub(' ', '_').downcase

      doc.render :pdf, :debug => true, :quality => :prepress,
          :filename => File.join(PUBLIC_DIRECTORY,"#{file_name}_#{@type}.pdf"),
          :logfile => File.join(TEMP_DIRECTORY,"relatorio_individual.log")
    end

  private
    def inc_page
      @inc_page ||= 0
      @inc_page += 1
    end

    def next_page_file(doc, index=true)
      page_file(inc_page, doc, index)
    end

    def page_file(pg_no, doc, index=true)
      add_index(doc, index)
      file = File.join("#{TEMPLATE_DIRECTORY}/#{@type}","pg_%04d.eps" % pg_no)
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)
      file
    end

    def add_index(doc, index=true)
      @index ||= 2
      doc.show "#{@index}", :with => :index, :align => :page_right if index
      @index += 1
    end

  end
end