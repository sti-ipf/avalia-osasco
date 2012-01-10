require 'rubygems'
require File.dirname(__FILE__)+'/../../config/application'
require File.dirname(__FILE__)+'/../../config/environment'
require 'pathname'

INDIVIDUAL_REPORT_CRECHE = File.expand_path "#{RAILS_ROOT}/lib/original_files/individual_creche.pdf"
INDIVIDUAL_REPORT_EMEF = File.expand_path "#{RAILS_ROOT}/lib/original_files/individual_emef.pdf"
INDIVIDUAL_REPORT_EJA = File.expand_path "#{RAILS_ROOT}/lib/original_files/individual_eja.pdf"
INDIVIDUAL_REPORT_EMEI = File.expand_path "#{RAILS_ROOT}/lib/original_files/individual_emei.pdf"
COVER = File.expand_path "#{RAILS_ROOT}/lib/original_files/capa.pdf"
EXPEDIENTE = File.expand_path "#{RAILS_ROOT}/lib/original_files/expediente.pdf"
TEMPLATE_DIRECTORY= File.expand_path "#{RAILS_ROOT}/lib/templates"
TEMP_DIRECTORY = File.expand_path "#{RAILS_ROOT}/tmp"



namespace :tools do
  namespace :generate do
      
    task :eps do
      abort "PAGE_START and PAGE_END are mandatody" if ENV['PAGE_START'].nil? || ENV['PAGE_END'].nil? || ENV['TYPE'].nil?
      page_start =  ENV['PAGE_START'].to_i
      page_end   =  ENV['PAGE_END'].to_i
      type = ENV['TYPE'].to_i
      type = ServiceLevel.find(type).name

      case type
        when 'CRECHE'
          report = INDIVIDUAL_REPORT_CRECHE
        when 'EMEF'
          report = INDIVIDUAL_REPORT_EMEF
        when 'EJA'
          report = INDIVIDUAL_REPORT_EJA
        when 'EMEI'
          report = INDIVIDUAL_REPORT_EMEI
      end

      (page_start..page_end).each do |i|
        eps_file = File.join("#{TEMPLATE_DIRECTORY}/#{type}","pg_00")
        page_number = (i.to_s.length == 1)? "0#{i}"  : i
        system "pdftops -eps -f #{i} -l #{i} #{report} #{eps_file}#{page_number}.eps 1> /dev/null 2> /dev/null"
      end
      eps_file = File.join(TEMPLATE_DIRECTORY,"capa")
      system "pdftops -eps -f 1 -l 1 #{COVER} #{eps_file}.eps 1> /dev/null 2> /dev/null"
      eps_file = File.join(TEMPLATE_DIRECTORY,"expediente")
      system "pdftops -eps -f 1 -l 1 #{EXPEDIENTE} #{eps_file}.eps 1> /dev/null 2> /dev/null"

    end

    task :questions do
      (1..10).each do |i|
        pdf_file = File.join(TEMPLATE_DIRECTORY,"1_1_#{i}_questoes.pdf")
        eps_file = File.join(TEMPLATE_DIRECTORY,"1_1_#{i}_questoes.eps")
        system "pdftops -eps -f 1 -l 1 #{pdf_file} #{eps_file} 1> /dev/null 2> /dev/null"
      end
    end
      
  end
end
