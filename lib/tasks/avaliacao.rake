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

end
