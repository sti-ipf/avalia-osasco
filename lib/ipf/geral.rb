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

      

      dimensions_total = Dimension.count(:conditions => "service_level_id = #{1}")

      y_points = {1 => 9, 2 => 17.5}
      [1, 2].each do |sl_id|
        doc.image next_page_file(doc)  
        file = File.join(TEMP_DIRECTORY,"#{sl_id}_dimensions_graphic_geral.jpg")
        doc.image file, :x => 1.6, :y => y_points[sl_id], :zoom => 55
        doc.showpage
        doc.image next_page_file(doc)

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

      doc.image next_page_file(doc)
      doc.next_page


      dimension_graphic_y_points = [0, 17, 6, 17, 1, 0.5, 0.5, 4, 0.5, 17, 3]

      (1..dimensions_total).each do |i|
        doc.image next_page_file(doc)
        file = File.join(TEMP_DIRECTORY,"1_2_#{i}_ue_dimension_graphic_report_geral.jpg")
        puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

        doc.image file, :x => 1.6, :y => dimension_graphic_y_points[i], :zoom => 53
        doc.showpage

        
        doc.image next_page_file(doc)
        graphics = 0
        count = 0
        indicator_number = 0
        file_exist = true

        while file_exist
          indicator_number += 1
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
          
          
          file = File.join(TEMP_DIRECTORY,"1_2_#{i}_#{indicator_number}_ue_indicator_graphic_geral.jpg")
          
          if !File.exists?(file)
            file_exist = false 
            doc.showpage if graphics < 4 && count < 4
            next
          end

          doc.image file, :x => 3, :y => y, :zoom => 45

          graphics += 1
          count += 1

          if graphics >= 4
            add_index(doc) if count > 4
            doc.showpage
            graphics = 0
          end

        end

        if ![5, 6, 7, 9].include?(i)
          doc.image next_page_file(doc)
          doc.next_page 
        end
      end

      # 6.times do |i|
      #   doc.image next_page_file(doc)
      #   doc.next_page if i != (i-1)
      # end



      group_data = {}
      groups = Group.all(:conditions => "service_level_id = 1")
      groups.each do |g|
        data = DimensionData.find_by_sql("
          SELECT dimension_number, ROUND(AVG(value),1) as calculated_media FROM dimension_data
          WHERE service_level_id = 1  and year = 2011
          AND school_id  IN (SELECT school_id FROM groups_schools WHERE group_id = #{g.id})
          GROUP BY year, dimension_number
          ORDER BY year, dimension_number
        ")
        group_data[g.id] = {}
        data.each do |d|
          group_data[g.id][d.dimension_number] = d.calculated_media
        end
      end

      y_numbers = [0, 18.4, 17.6, 16.6, 15.8, 15, 14.3, 13.5, 12.2, 11.2, 10.4]
      (1..dimensions_total).each do |i|
        x_number = 9.5
        groups.each do |g|
          doc.moveto :x => x_number, :y => y_numbers[i]
          doc.show group_data[g.id][i], :with => :font2, :align => :show_center 
          x_number += 2.6
        end
      end

      doc.image next_page_file(doc)
      doc.next_page


      doc.image next_page_file(doc)
      doc.next_page

      group_data = {}
      groups = Group.all(:conditions => "service_level_id = 2")
      groups.each do |g|
        data = DimensionData.find_by_sql("
          SELECT dimension_number, ROUND(AVG(value),1) as calculated_media FROM dimension_data
          WHERE service_level_id = 2  and year = 2011
          AND school_id  IN (SELECT school_id FROM groups_schools WHERE group_id = #{g.id})
          GROUP BY year, dimension_number
          ORDER BY year, dimension_number
        ")
        group_data[g.id] = {}
        data.each do |d|
          group_data[g.id][d.dimension_number] = d.calculated_media
        end
      end

      y_numbers = [0, 25.8, 25, 23.8, 23, 22.1, 21.2, 20.3, 19, 17.9, 16.9]
      (1..dimensions_total).each do |i|
        x_number = 9.5
        groups.each do |g|
          doc.moveto :x => x_number, :y => y_numbers[i]
          doc.show group_data[g.id][i], :with => :font2, :align => :show_center 
          x_number += 2.6
        end
      end

      doc.image next_page_file(doc)
      doc.next_page

      file = File.join(TEMPLATE_DIRECTORY,"CRECHE_legend.jpg")
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

      doc.image file, :x => 1.6, :y => 10.5, :zoom => 50

      doc.image next_page_file(doc)
      doc.next_page

      file = File.join(TEMPLATE_DIRECTORY,"CRECHE_table.jpg")
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

      doc.image file, :x => 1.6, :y => 9, :zoom => 50  

      doc.image next_page_file(doc)
      doc.next_page

      file = File.join(TEMPLATE_DIRECTORY,"EMEI_legend.jpg")
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

      doc.image file, :x => 1.6, :y => 7, :zoom => 50  

      doc.image next_page_file(doc)
      doc.next_page

      file = File.join(TEMPLATE_DIRECTORY,"EMEI_table.jpg")
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

      doc.image file, :x => 1.6, :y => 6, :zoom => 50  

      doc.image next_page_file(doc)
      doc.next_page

      doc.image next_page_file(doc)
      doc.next_page

      dimensions_total = Dimension.count(:conditions => "service_level_id = #{6}")

      dimension_graphic_y_points = [0, 13, 6, 17, 17, 0.5, 17, 4, 0.5, 17, 3]

      (1..dimensions_total).each do |i|
        doc.image next_page_file(doc)
        file = File.join(TEMP_DIRECTORY,"6__#{i}_ue_dimension_graphic_report_geral.jpg")
        puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

        doc.image file, :x => 1.6, :y => dimension_graphic_y_points[i], :zoom => 53
        doc.showpage

        
        doc.image next_page_file(doc)
        graphics = 0
        count = 0
        indicator_number = 0
        file_exist = true

        while file_exist
          indicator_number += 1
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
          
          
          file = File.join(TEMP_DIRECTORY,"6__#{i}_#{indicator_number}_ue_indicator_graphic_geral.jpg")
          
          if !File.exists?(file)
            file_exist = false 
            doc.showpage if graphics < 4 && count < 4
            next
          end

          doc.image file, :x => 3, :y => y, :zoom => 45

          graphics += 1
          count += 1

          if graphics >= 4
            add_index(doc) if count > 4
            doc.showpage
            graphics = 0
          end

        end

        if ![6, 7, 9].include?(i)
          doc.image next_page_file(doc)
          doc.next_page 
        end
        if [3].include?(i)
          doc.image next_page_file(doc)
          doc.next_page 
        end
      end

      group_data = {}
      groups = Group.all(:conditions => "service_level_id = 6")
      groups.each do |g|
        data = DimensionData.find_by_sql("
          SELECT dimension_number, ROUND(AVG(value),1) as calculated_media FROM dimension_data
          WHERE service_level_id = 6  and year = 2011
          AND school_id  IN (SELECT school_id FROM groups_schools WHERE group_id = #{g.id})
          GROUP BY year, dimension_number
          ORDER BY year, dimension_number
        ")
        group_data[g.id] = {}
        data.each do |d|
          group_data[g.id][d.dimension_number] = d.calculated_media
        end
      end

      y_numbers = [0, 17.6, 16.8, 15.8, 15, 14.1, 13.2, 12.4, 11.1, 10.2, 9.4]
      (1..dimensions_total).each do |i|
        x_number = 9.5
        groups.each do |g|
          doc.moveto :x => x_number, :y => y_numbers[i]
          doc.show group_data[g.id][i], :with => :font2, :align => :show_center 
          x_number += 2.6
        end
      end

      doc.image next_page_file(doc)
      doc.next_page 

      file = File.join(TEMPLATE_DIRECTORY,"CRECHE CONVENIADA_legend.jpg")
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)
      doc.image file, :x => 1.6, :y => 18, :zoom => 50  
      
      file = File.join(TEMPLATE_DIRECTORY,"CRECHE CONVENIADA_table.jpg")
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

      doc.image file, :x => 1.6, :y => 5, :zoom => 50  

      doc.image next_page_file(doc)
      doc.next_page 
      


      dimensions_total = Dimension.count(:conditions => "service_level_id = #{3}")

      y_points = {3 => 10}
      [3].each do |sl_id|
        doc.image next_page_file(doc)  
        file = File.join(TEMP_DIRECTORY,"#{sl_id}_dimensions_graphic_geral.jpg")
        doc.image file, :x => 1.6, :y => y_points[sl_id], :zoom => 55
        doc.showpage
        doc.image next_page_file(doc)

        y = 18
        (1..dimensions_total).each do |i|      
          file = File.join(TEMP_DIRECTORY,"#{sl_id}_#{i}_dimension_graphic_geral.jpg")
          puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

          doc.image file, :x => 1.6, :y => y, :zoom => 48

          if [4, 6, 8, 10].include?(i)
            y = 5.8
            if i == 10
              y = 7
            end
          else
            y = 20
            doc.showpage 
            doc.image next_page_file(doc) if i != dimensions_total
          end

        end
      end

      doc.image next_page_file(doc)
      doc.next_page


      dimension_graphic_y_points = [0, 17, 6, 12, 2, 1.5, 17, 4, 0.5, 13.5, 4, 7.5]

      (1..dimensions_total).each do |i|
        doc.image next_page_file(doc)
        file = File.join(TEMP_DIRECTORY,"3__#{i}_ue_dimension_graphic_report_geral.jpg")
        puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

        doc.image file, :x => 1.6, :y => dimension_graphic_y_points[i], :zoom => 53
        doc.showpage

        
        doc.image next_page_file(doc)
        graphics = 0
        count = 0
        indicator_number = 0
        file_exist = true

        while file_exist
          indicator_number += 1
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
          
          
          file = File.join(TEMP_DIRECTORY,"3__#{i}_#{indicator_number}_ue_indicator_graphic_geral.jpg")
          
          if !File.exists?(file)
            file_exist = false 
            doc.showpage if graphics < 4 && count < 4
            next
          end

          doc.image file, :x => 3, :y => y, :zoom => 45

          graphics += 1
          count += 1

          if graphics >= 4
            add_index(doc) if count > 4
            doc.showpage
            graphics = 0
          end

        end

        if ![6, 7, 9, 10].include?(i)
          doc.image next_page_file(doc)
          doc.next_page 
        end
      end

      2.times do |i|
        doc.image next_page_file(doc)
        doc.next_page if i != (i-1)
      end

      group_data = {}
      groups = Group.all(:conditions => "service_level_id = 3")
      groups.each do |g|
        data = DimensionData.find_by_sql("
          SELECT dimension_number, ROUND(AVG(value),1) as calculated_media FROM dimension_data
          WHERE service_level_id = 3  and year = 2011
          AND school_id  IN (SELECT school_id FROM groups_schools WHERE group_id = #{g.id})
          GROUP BY year, dimension_number
          ORDER BY year, dimension_number
        ")
        group_data[g.id] = {}
        data.each do |d|
          group_data[g.id][d.dimension_number] = d.calculated_media
        end
      end

      y_numbers = [0, 26, 25.2, 24.2, 23.4, 22.5, 21.8, 20.9, 19.7, 18.8, 18, 17]
      (1..dimensions_total).each do |i|
        x_number = 9.5
        groups.each do |g|
          doc.moveto :x => x_number, :y => y_numbers[i]
          doc.show group_data[g.id][i], :with => :font2, :align => :show_center 
          x_number += 2.6
        end
      end

      doc.image next_page_file(doc)
      doc.next_page 

      file = File.join(TEMPLATE_DIRECTORY,"EMEF_legend.jpg")
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)
      doc.image file, :x => 1.6, :y => 8.5, :zoom => 50  

      doc.image next_page_file(doc)
      doc.next_page 
      
      file = File.join(TEMPLATE_DIRECTORY,"EMEF_table.jpg")
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

      doc.image file, :x => 1.6, :y => 6, :zoom => 50  

      doc.image next_page_file(doc)
      doc.next_page 

      doc.image next_page_file(doc)
      doc.next_page 

      


      dimensions_total = Dimension.count(:conditions => "service_level_id = #{4}")

      dimension_graphic_y_points = [0, 16, 2, 2, 0.5, 0.5, 4, 5, 3, 7]

      (1..dimensions_total).each do |i|
        doc.image next_page_file(doc)
        file = File.join(TEMP_DIRECTORY,"4__#{i}_ue_dimension_graphic_report_geral.jpg")
        puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

        doc.image file, :x => 1.6, :y => dimension_graphic_y_points[i], :zoom => 53
        doc.showpage

        
        doc.image next_page_file(doc)
        graphics = 0
        count = 0
        indicator_number = 0
        file_exist = true

        while file_exist
          indicator_number += 1
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
          
          
          file = File.join(TEMP_DIRECTORY,"4__#{i}_#{indicator_number}_ue_indicator_graphic_geral.jpg")
          
          if !File.exists?(file)
            file_exist = false 
            doc.showpage if graphics < 4 && count < 4
            next
          end

          doc.image file, :x => 3, :y => y, :zoom => 45

          graphics += 1
          count += 1

          if graphics >= 4
            add_index(doc) if count > 4
            doc.showpage
            graphics = 0
          end

        end

        if ![2, 3, 4, 5, 6, 7, 8, 9].include?(i)
          doc.image next_page_file(doc)
          doc.next_page 
        end
        if [].include?(i)
          doc.image next_page_file(doc)
          doc.next_page 
        end
      end

      doc.image next_page_file(doc)
      doc.next_page 

      group_data = {}
      groups = Group.all(:conditions => "service_level_id = 4")
      groups.each do |g|
        data = DimensionData.find_by_sql("
          SELECT dimension_number, ROUND(AVG(value),1) as calculated_media FROM dimension_data
          WHERE service_level_id = 4  and year = 2011
          AND school_id  IN (SELECT school_id FROM groups_schools WHERE group_id = #{g.id})
          GROUP BY year, dimension_number
          ORDER BY year, dimension_number
        ")
        group_data[g.id] = {}
        data.each do |d|
          group_data[g.id][d.dimension_number] = d.calculated_media
        end
      end

      y_numbers = [0, 21, 20.2, 19.5, 18.6, 17.8, 17, 16.2, 15.5, 14.5]
      (1..dimensions_total).each do |i|
        x_number = 9.5
        groups.each do |g|
          doc.moveto :x => x_number, :y => y_numbers[i]
          doc.show group_data[g.id][i], :with => :font2, :align => :show_center 
          x_number += 2.6
        end
      end

      
      doc.image next_page_file(doc)
      doc.next_page 

      file = File.join(TEMPLATE_DIRECTORY,"EJA_legend.jpg")
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)
      doc.image file, :x => 1.6, :y => 14, :zoom => 50  

      doc.image next_page_file(doc)
      doc.next_page 

      file = File.join(TEMPLATE_DIRECTORY,"EJA_table.jpg")
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)
      doc.image file, :x => 1.6, :y => 12, :zoom => 50  

      doc.image next_page_file(doc)
      doc.next_page 

      doc.image next_page_file(doc)
      


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
      case pg_no.to_s.length
        when 1
          zeros = '000'
        when 2
          zeros = '00'
        when 3
          zeros = '00'
      end
      file = File.join("#{TEMPLATE_DIRECTORY}/#{@type}","pg_#{zeros}#{pg_no}.eps")
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