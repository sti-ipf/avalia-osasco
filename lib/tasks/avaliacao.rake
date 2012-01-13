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
    schools = School.find_by_sql(
      "SELECT * FROM schools WHERE id IN (select school_id from schools_service_levels where service_level_id IN (5))"
    )
    schools.each do |s|
      s.service_levels.each do |sl|
        puts s.id
        report = IPF::Report.new
        report.generate_graphics(s.id, sl.id)
        #report.generate_question_tables(s.id, sl.id)
        #report.generate_practice_tables(s.id, sl.id)
        #report.generate_index_table(s.id, sl.id)
        report.generate_file(s.id, sl.id)
      end      
      # s_id = 32#70#68
      # service_level = 4#4#3
      
      # report.generate_graphics(s_id, service_level)
      # report.generate_question_tables(s_id, service_level)
      # report.generate_practice_tables(s_id, service_level)
      # report.generate_index_table(s_id, service_level)
      # report.generate_file(s_id, service_level)
      # break
    end
    
  end

end
