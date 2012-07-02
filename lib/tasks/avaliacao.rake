require 'rubygems'
require File.dirname(__FILE__)+'/../../config/application'
require File.dirname(__FILE__)+'/../../config/environment'

namespace :tasks do

	task :import_instrument => :environment do
		Ipf::Instrument.import("#{RAILS_ROOT}/tmp/instrumental_osasco.csv")
	end

	task :generate_passwords_to_sorocaba => :environment do
		generator = IPF::PasswordGenerator.new
		generator.generate_for_sorocaba
	end

  task :generate_passwords_to_osasco => :environment do
    generator = IPF::PasswordGenerator.new
    generator.generate_all
  end

	task :generate_answer_stats => :environment do
		IPF::AnswerStat.generate
	end

  task :generate_question_tables => :environment do
    schools = School.find_by_sql(
      "SELECT * FROM schools WHERE id IN (select school_id from schools_service_levels where service_level_id = 4)"
    )
    schools.each do |s|
      puts s.id
      report = IPF::Report.new
      report.generate_question_tables(s.id, 4)
    end
  end

  task :generate_all_report => :environment do
    # schools = School.find_by_sql(
    #   "SELECT * FROM schools WHERE id IN (
    #     SELECT school_id FROM groups_schools 
    #       WHERE group_id IN (
    #         SELECT id FROM groups WHERE name = 'Grupo 4' AND service_level_id = 1 
    #       )
    #     )"
    # )

    #IPF::Report.new.generate_file(120, 2)
    #143
    #schools = School.all(:conditions => "id NOT IN (143) AND id IN (select school_id from schools_service_levels where service_level_id = 6)")
    #schools = School.all(:conditions => "id IN (157)")
    schools = School.all(:conditions => "id IN (14, 30, 48)")
    schools.each do |s|
        s_id = s.id#135#23
        s.service_levels.each do |sl|
            #sl_id = 6#1
            sl_id = sl.id
            report = IPF::Report.new
            # puts '-' * 100
            # puts s.id
            # puts '-' * 100
            report.generate_graphics(s_id, sl_id)
            report.generate_question_tables(s_id, sl_id)
            report.generate_practice_tables(s_id, sl_id)
            report.generate_index_table(s_id, sl_id)
            report.generate_file(s_id, sl_id)
        end
    end
    # schools = School.find_by_sql(
    #   "SELECT * FROM schools WHERE id IN (select school_id from schools_service_levels where service_level_id IN (6))"
    # )
    # schools.each do |s|
    #   s.service_levels.each do |sl|
    #     puts s.id
    #     report = IPF::Report.new
    #     report.generate_graphics(s.id, sl.id)
    #     report.generate_question_tables(s.id, sl.id)
    #     report.generate_practice_tables(s.id, sl.id)
    #     report.generate_index_table(s.id, sl.id)
    #     #report.generate_file(s.id, sl.id)
    #   end      
    #   # s_id = 32#70#68
    #   # service_level = 4#4#3
      
    #   # report.generate_graphics(s_id, service_level)
    #   # report.generate_question_tables(s_id, service_level)
    #   # report.generate_practice_tables(s_id, service_level)
    #   # report.generate_index_table(s_id, service_level)
    #   # report.generate_file(s_id, service_level)
    #   # break
    # end
  end

  task :generate_burjato => :environment do
    s_id = 134
    sl_id = 5
    report = IPF::Burjato.new
    report.generate_graphics(s_id, sl_id)
    report.generate_question_tables(s_id, sl_id)
    report.generate_practice_tables(s_id, sl_id)
    report.generate_index_table(s_id, sl_id)
    report.generate_file(s_id, sl_id)
  end

  task :do_not_answer_report => :environment do
    data = {}
    header = ['Nível de serviço', 'Segmento', 'Questão', 'Número da questão', 'Total', 'Frequencia']
    file  = FasterCSV.open("tmp/relatorio_nao_quero_responder.csv", "w")
    file << header
    ServiceLevel.all.each do |s|
      data[s.id] = {}
      schools_ids = s.schools.collect(&:id).join(",")
      s.segments.each do |ss|
        result = Answer.find_by_sql("
          select SUM(do_not_answer) as total, SUM(quantity_of_people) as quantity_of_people, 
          a.question_text_id, qt.text as question, qt.question_number as question_number from answers a
          INNER JOIN question_texts qt ON qt.id = a.question_text_id
          where a.do_not_answer is not null 
          AND a.school_id IN (#{schools_ids})
          AND a.segment_id = #{ss.id}
          group by question_text_id
          ")
        data[s.id][ss.id] = result
      end

      s.segments.each do |ss|
        #file  = FasterCSV.open("tmp/#{s.name}-#{ss.name}.csv", "w")
        #file << header
        data[s.id][ss.id].each do |d|
          next if d.total == 0
          new_array = Array.new(6)
          new_array[0] = s.name
          new_array[1] = ss.name
          new_array[2] = d.question
          new_array[3] = "\"#{d.question_number.to_s}\""
          new_array[4] = d.total.to_i
          new_array[5] = "#{d.total.to_i} / #{d.quantity_of_people} (total de respostas)"
          
          (0..5).each do |i|
            new_array[i] = "  " if new_array[i].blank?
          end
          file << new_array
        end
        #file.close
      end
    end
    file.close


  end
end


