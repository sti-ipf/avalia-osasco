module IPF
  class Geral

    TEMPLATE_DIRECTORY= File.expand_path "#{RAILS_ROOT}/lib/templates/GERAL"
    TEMP_DIRECTORY = File.expand_path "#{RAILS_ROOT}/tmp"
    PUBLIC_DIRECTORY = File.expand_path "#{RAILS_ROOT}/public"

    def self.clean_name(school_name, sl_id)
      if sl_id == 6
        file_name = school_name.gsub(/[^a-z0-9çâãáàêẽéèîĩíìõôóòũûúù' ']+/i, '').gsub(' ', '_').gsub('[âãáàêẽéèîĩíìõôóòũûúù]','').downcase
        file_name = file_name.gsub(/[á|à|ã|â|ä]/, 'a').gsub(/(é|è|ê|ë)/, 'e').gsub(/(í|ì|î|ï)/, 'i').gsub(/(ó|ò|õ|ô|ö)/, 'o').gsub(/(ú|ù|û|ü)/, 'u')
        file_name = file_name.gsub(/(Á|À|Ã|Â|Ä)/, 'A').gsub(/(É|È|Ê|Ë)/, 'E').gsub(/(Í|Ì|Î|Ï)/, 'I').gsub(/(Ó|Ò|Õ|Ô|Ö)/, 'O').gsub(/(Ú|Ù|Û|Ü)/, 'U')
        file_name = file_name.gsub(/ñ/, 'n').gsub(/Ñ/, 'N')
        file_name = file_name.gsub(/ç/, 'c').gsub(/Ç/, 'C')
      else
        file_name = school_name.gsub(/[^a-z0-9çâãáàêẽéèîĩíìõôóòũûúù' ']+/i, '').gsub(' ', '_').gsub('[âãáàêẽéèîĩíìõôóòũûúù]','').downcase
      end
      file_name
    end

    def generate_graphics
      [[1,2], [6], [3], [4]].each do |sl|
        dimensions = Dimension.all(:conditions => "service_level_id = #{sl.first}")
        sl.each do |id|
          DimensionData.generate_dimensions_graphic_geral(id)
        end
        dimensions.each do |d|
          puts "GERANDO GRÁFICOS PARA A DIMENSAO #{d.number}"
          sl.each do |id|
            DimensionData.generate_graphic_per_dimension_geral(id, d.number)
          end
          ReportData.dimension_graphic_geral(sl, d.number)
          indicators = Indicator.all(:conditions => "dimension_id = #{d.id}", :order => "number ASC").collect(&:number)
          indicators.each do |i|
            ReportData.indicator_graphic_geral(sl, d.number, i)
          end
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

    def generate_file
      doc = RGhost::Document.new
      doc.define_tags do
        tag :font1, :name => 'HelveticaBold', :size => 12, :color => '#000000'
        tag :font2, :name => 'Helvetica', :size => 12, :color => '#000000'
        tag :font3, :name => 'CalibriBold', :size => 13, :color => '#535353'
        tag :index, :name => 'Helvetica', :size => 8, :color => '#000000'
        tag :indexwhite, :name => 'Helvetica', :size => 8, :color => '#FFFFFF'
      end

      ['capa', 'expediente'].each do |s|
        doc.image File.join(TEMPLATE_DIRECTORY, "#{s}.eps")
        doc.next_page
      end

      25.times do |i|
        doc.image next_page_file(doc)
        doc.next_page if i != (i-1)
      end

      

      y_points = {1 => 9, 2 => 17.5}
      [1, 2].each do |sl_id|
        doc.image next_page_file(doc)  
        file = File.join(TEMP_DIRECTORY,"#{sl_id}_dimensions_graphic_geral.jpg")
        doc.image file, :x => 1.6, :y => y_points[sl_id], :zoom => 55
        doc.showpage
        doc.image next_page_file(doc)

        dimensions_total = Dimension.count(:conditions => "service_level_id = #{sl_id}")
        y = 18
        (1..dimensions_total).each do |i|      
          file = File.join(TEMP_DIRECTORY,"#{sl_id}_#{i}_dimension_graphic_geral.jpg")
          puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

          doc.image file, :x => 1.6, :y => y, :zoom => 50

          if [4, 6, 8].include?(i)
            y = 5.5
          else
            y = 18.5
            doc.showpage 
            doc.image next_page_file(doc) if i != dimensions_total
          end

        end
      end

      # if (@type != "EJA" && @type != "CONVENIADA")
        

      
      #   puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

      
      

      # dimension_graphic_y_points = [0, 10, 12.5, 12.5, 12, 11, 12.5, 12.5, 11, 13.5, 12.5, 12.5]

      # (1..dimensions_total).each do |i|

      #   dimension = Dimension.first(:conditions => "service_level_id = #{service_level_id} AND number = #{i}")
      #   doc.image next_page_file(doc)
      #   file = File.join(TEMP_DIRECTORY,"#{school_id}_#{service_level_id}_#{i}_ue_dimension_graphic.jpg")
      #   puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

      #   doc.image file, :x => 1.6, :y => dimension_graphic_y_points[i], :zoom => 55
      #   doc.showpage

        
      #   doc.image next_page_file(doc)
      #   graphics = 0
      #   indicators = Indicator.all(:conditions => "dimension_id = #{dimension.id} and id NOT IN (262, 267, 281, 285)", :order => "number ASC").collect(&:number)
      #   count = 0


      #   indicators.each do |indicator|
      #     case graphics
      #       when 0
      #         y = 20.4
      #       when 1
      #         y = 14
      #       when 2
      #         y = 7.5
      #       when 3
      #         y = 1
      #     end
          
          
      #     file = File.join(TEMP_DIRECTORY,"#{school_id}_#{service_level_id}_#{i}_#{indicator}_ue_indicator_graphic.jpg")
      #     puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

      #     doc.image file, :x => 3, :y => y, :zoom => 45

      #     graphics += 1
      #     count += 1

      #     if graphics >= 4
      #       add_index(doc) if count > 4
      #       doc.showpage
      #       graphics = 0
      #     end

      #   end
        
      #   if graphics != 0 && indicators.count > 4
      #     add_index(doc)
      #     doc.showpage
      #   end

      #   if graphics < 4 && indicators.count < 4
      #     doc.showpage
      #   end


      #   if @type == "EJA" || @type == "CONVENIADA"
      #     question_y_points = [0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
      #   else
      #     question_y_points = [0, 9, 9, 6, 9, 9, 9, 9, 9, 9, 9, 9]
      #   end
        
        
      #   doc.image next_page_file(doc)
      #   file = File.join(TEMPLATE_DIRECTORY,"#{school_id}_#{service_level_id}_#{i}_questoes.jpg")
      #   doc.image file, :x => 1.6, :y => question_y_points[i], :zoom => 50
      #   doc.showpage

      #   doc.image next_page_file(doc)
      #   file = File.join(TEMPLATE_DIRECTORY,"#{school_id}_#{service_level_id}_#{i}_praticas.jpg")
      #   doc.image file, :x => 1.6, :y => 21.5, :zoom => 50
      #   doc.next_page 

      #   if @type != "CONVENIADA"
      #     doc.image next_page_file(doc)
      #     doc.next_page 
      #   end
        
      # end

      # doc.image next_page_file(doc)
      # doc.next_page 

      # doc.image next_page_file(doc)
      # file = File.join(TEMPLATE_DIRECTORY,"#{school_id}_#{service_level_id}_index.jpg")
      # doc.image file, :x => 1.6, :y => 9, :zoom => 50
      # doc.next_page 

      # doc.image next_page_file(doc)


      doc.render :pdf, :debug => true, :quality => :prepress,
          :filename => File.join(PUBLIC_DIRECTORY,"GERAL.pdf"),
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
      if @index.even?
        doc.show "#{@index}", :with => :index, :align => :page_left if index        
      else
        doc.show "#{@index}", :with => :index, :align => :page_right if index
      end
      @index += 1
    end

  end
end