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

      20.times do |i|
        doc.image next_page_file(doc)
        doc.next_page if i != (i-1)
      end

      segment_tmp = Answer.find_by_sql("SELECT s.name as name, ROUND(AVG(quantity_of_people),1) AS calculated_media FROM answers a 
        INNER JOIN segments s on a.segment_id = s.id
        INNER JOIN schools ss on a.school_id = ss.id
        WHERE s.id IN (SELECT id FROM segments WHERE service_level_id = 1)
        GROUP BY ss.name, s.name")
      segment_data = Hash.new
      segment_tmp.each do |s|
        segment_data[s.name] ||= []
        segment_data[s.name] << s.calculated_media.to_i
      end

      ['Gestores', 'Professores', 'Funcionários', 'Familiares'].each do |s|
        total = 0
        segment_data[s].each do |ss|
          total += ss
        end
        segment_data[s] = total
      end
      
      i = 0
      y_numbers = [13.1, 12.5, 11.9, 11.2]
      segments = ['Gestores', 'Professores', 'Funcionários', 'Familiares']
      segments.each do |s|
        doc.moveto :x => 14.9, :y => y_numbers[i]
        doc.show segment_data[s], :with => :font2, :align => :show_center 
        i += 1
      end

      segment_tmp = Answer.find_by_sql("SELECT s.name as name, ROUND(AVG(quantity_of_people),1) AS calculated_media FROM answers a 
        INNER JOIN segments s on a.segment_id = s.id
        INNER JOIN schools ss on a.school_id = ss.id
        WHERE s.id IN (SELECT id FROM segments WHERE service_level_id = 2)
        GROUP BY ss.name, s.name")
      segment_data = Hash.new
      segment_tmp.each do |s|
        segment_data[s.name] ||= []
        segment_data[s.name] << s.calculated_media.to_i
      end

      ['Gestores', 'Professores', 'Funcionários', 'Familiares'].each do |s|
        total = 0
        segment_data[s].each do |ss|
          total += ss
        end
        segment_data[s] = total
      end
      
      i = 0
      y_numbers = [8.1, 7.4, 6.8, 6.1]
      segments = ['Gestores', 'Professores', 'Funcionários', 'Familiares']
      segments.each do |s|
        doc.moveto :x => 14.9, :y => y_numbers[i]
        doc.show segment_data[s], :with => :font2, :align => :show_center 
        i += 1
      end

      doc.image next_page_file(doc)
      doc.next_page 

      dimensions_total = Dimension.count(:conditions => "service_level_id = #{1}")

      y_points = {1 => 10.8, 2 => 17.5}
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

          if sl_id == 2 && i == 4
            y = 5
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

        if ![5, 6, 7, 9, 10].include?(i)
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
      group_data = ReportData.get_group_data_geral(1)

      y_numbers = [0, 11.8, 11, 10, 9.2, 8.3, 7.6, 6.8, 5.5, 4.5, 3.8]
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
      group_data = ReportData.get_group_data_geral(2)

      y_numbers = [0, 23.9, 23, 22.1, 21.3, 20.4, 19.8, 19, 17.9, 16.7, 16]
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

      file = File.join(TEMPLATE_DIRECTORY,"CRECHE_legend.jpg")
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

      doc.image file, :x => 1.6, :y => 5, :zoom => 50

      doc.image next_page_file(doc)
      doc.next_page

      file = File.join(TEMPLATE_DIRECTORY,"CRECHE_table.jpg")
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

      doc.image file, :x => 1.6, :y => 8, :zoom => 50  

      doc.image next_page_file(doc)
      doc.next_page

      file = File.join(TEMPLATE_DIRECTORY,"EMEI_legend.jpg")
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

      doc.image file, :x => 1.6, :y => 1, :zoom => 50  

      doc.image next_page_file(doc)
      doc.next_page

      file = File.join(TEMPLATE_DIRECTORY,"EMEI_table.jpg")
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

      doc.image file, :x => 1.6, :y => 6, :zoom => 50  

      doc.image next_page_file(doc)
      doc.next_page

      segment_tmp = Answer.find_by_sql("SELECT s.name as name, ROUND(AVG(quantity_of_people),1) AS calculated_media FROM answers a 
        INNER JOIN segments s on a.segment_id = s.id
        INNER JOIN schools ss on a.school_id = ss.id
        WHERE s.id IN (SELECT id FROM segments WHERE service_level_id = 6)
        GROUP BY ss.name, s.name")
      segment_data = Hash.new
      segment_tmp.each do |s|
        segment_data[s.name] ||= []
        segment_data[s.name] << s.calculated_media.to_i
      end

      ['Gestores', 'Coordenadores pedagógicos', 'Professores', 'Funcionários', 'Familiares'].each do |s|
        total = 0
        segment_data[s].each do |ss|
          total += ss
        end
        segment_data[s] = total
      end
      
      i = 0
      y_numbers = [16.2, 15.5, 14.9, 14.3, 13.6]
      segments = ['Gestores', 'Coordenadores pedagógicos', 'Professores', 'Funcionários', 'Familiares']
      segments.each do |s|
        doc.moveto :x => 14.9, :y => y_numbers[i]
        doc.show segment_data[s], :with => :font2, :align => :show_center 
        i += 1
      end

      doc.image next_page_file(doc)
      doc.next_page

      dimensions_total = Dimension.count(:conditions => "service_level_id = #{6}")

      dimension_graphic_y_points = [0, 7.5, 5, 17, 17, 3.4, 17, 4, 0.5, 17, 3]

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
          next if ['3.10', '4.5', '9.2', '10.3'].include?("#{i}.#{indicator_number}")
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

        if ![4, 6, 7, 9, 10].include?(i)
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
      group_data = ReportData.get_group_data_geral(6)

      y_numbers = [0, 16, 15.1, 14.2, 13.3, 12.4, 11.6, 10.8, 9.5, 8.5, 7.7]
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

      file = File.join(TEMPLATE_DIRECTORY,"CRECHE CONVENIADA_legend.jpg")
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)
      doc.image file, :x => 1.6, :y => 16, :zoom => 50  
      
      file = File.join(TEMPLATE_DIRECTORY,"CRECHE CONVENIADA_table.jpg")
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

      doc.image file, :x => 1.6, :y => 4, :zoom => 50  

      doc.image next_page_file(doc)
      doc.next_page 
      
      segment_tmp = Answer.find_by_sql("SELECT s.name as name, ROUND(AVG(quantity_of_people),1) AS calculated_media FROM answers a 
        INNER JOIN segments s on a.segment_id = s.id
        INNER JOIN schools ss on a.school_id = ss.id
        WHERE s.id IN (SELECT id FROM segments WHERE service_level_id = 3)
        GROUP BY ss.name, s.name")
      segment_data = Hash.new
      segment_tmp.each do |s|
        segment_data[s.name] ||= []
        segment_data[s.name] << s.calculated_media.to_i
      end

      ['Gestores', 'Professores', 'Funcionários', 'Familiares', 'Educandos'].each do |s|
        total = 0
        segment_data[s].each do |ss|
          total += ss
        end
        segment_data[s] = total
      end
      
      i = 0
      y_numbers = [24.2, 23.5, 22.9, 22.2, 21.6]
      segments = ['Gestores', 'Professores', 'Funcionários', 'Familiares', 'Educandos']
      segments.each do |s|
        doc.moveto :x => 14.9, :y => y_numbers[i]
        doc.show segment_data[s], :with => :font2, :align => :show_center 
        i += 1
      end

      dimensions_total = Dimension.count(:conditions => "service_level_id = #{3}")

      y_points = {3 => 3.5}
      [3].each do |sl_id|
        doc.image next_page_file(doc)  
        file = File.join(TEMP_DIRECTORY,"#{sl_id}_dimensions_graphic_geral.jpg")
        doc.image file, :x => 1.6, :y => y_points[sl_id], :zoom => 55
        doc.showpage
        doc.image next_page_file(doc)

        y = 10.5
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

      doc.image next_page_file(doc)
      doc.next_page 

      group_data = {}
      groups = Group.all(:conditions => "service_level_id = 3")
      group_data = ReportData.get_group_data_geral(3)

      y_numbers = [0, 24.6, 23.8, 22.8, 22, 21.2, 20.4, 19.5, 18.5, 17.4, 16.6, 15.7]
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

      doc.image next_page_file(doc)
      doc.next_page 

      file = File.join(TEMPLATE_DIRECTORY,"EMEF_legend.jpg")
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)
      doc.image file, :x => 1.6, :y => 1.5, :zoom => 50  

      doc.image next_page_file(doc)
      doc.next_page 
      
      file = File.join(TEMPLATE_DIRECTORY,"EMEF_table.jpg")
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

      doc.image file, :x => 0.5, :y => 6, :zoom => 50

      doc.image next_page_file(doc)
      doc.next_page 

      segment_tmp = Answer.find_by_sql("SELECT s.name as name, ROUND(AVG(quantity_of_people),1) AS calculated_media FROM answers a 
        INNER JOIN segments s on a.segment_id = s.id
        INNER JOIN schools ss on a.school_id = ss.id
        WHERE s.id IN (SELECT id FROM segments WHERE service_level_id = 4)
        GROUP BY ss.name, s.name")
      segment_data = Hash.new
      segment_tmp.each do |s|
        segment_data[s.name] ||= []
        segment_data[s.name] << s.calculated_media.to_i
      end

      ['Gestores', 'Professores', 'Funcionários', 'Educandos'].each do |s|
        total = 0
        segment_data[s].each do |ss|
          total += ss
        end
        segment_data[s] = total
      end
      
      i = 0
      y_numbers = [21.1, 20.4, 19.8, 19.2]
      segments = ['Gestores', 'Professores', 'Funcionários', 'Educandos']
      segments.each do |s|
        doc.moveto :x => 14.9, :y => y_numbers[i]
        doc.show segment_data[s], :with => :font2, :align => :show_center 
        i += 1
      end

      doc.image next_page_file(doc)
      doc.next_page 


      dimensions_total = Dimension.count(:conditions => "service_level_id = #{4}")

      dimension_graphic_y_points = [0, 9, 4, 2, 0.5, 0.5, 4, 5, 3, 7]

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

      group_data = {}
      groups = Group.all(:conditions => "service_level_id = 4")
      group_data = ReportData.get_group_data_geral(4)

      y_numbers = [0, 10.1, 9.4, 8.5, 7.8, 6.9, 6.2, 5.3, 4.5, 3.5]
      (1..9).each do |i|
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

      file = File.join(TEMPLATE_DIRECTORY,"EJA_legend.jpg")
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)
      doc.image file, :x => 1.6, :y => 8, :zoom => 50  

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
        doc.show "#{@index}", :with => :index, :align => :page_right if index        
      else
        doc.show "#{@index}", :with => :index, :align => :page_left if index
      end
      @index += 1
    end

  end
end