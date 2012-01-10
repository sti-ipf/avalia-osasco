# -*- encoding : utf-8 -*-
require 'spec_helper'

describe IPF do
  it 'first test' do
    @school = School.first
    report = IPF::Report.new(:type => 'individual', :school => @school, :service_level => @school.service_levels.first,
      :template => "#{RAILS_ROOT}/public/reports/artifacts/capa_avaliação.pdf")
    report.generate_file
  end

end

