module Ipf

  class Import

    CSV_OPTIONS = {:col_sep => ";"}

    def self.services_levels(file)
      data = FasterCSV.read(file, CSV_OPTIONS)
      data.each do |d|
        next if d[0] == 'Nome'
        ServiceLevel.create(:name => d[0])
      end
    end

    def self.schools(file)
      data = FasterCSV.read(file, CSV_OPTIONS)
      data.each do |d|
        next if d[0] == 'Nome'
        levels = []
        (2..10).each do |i|
          levels << ServiceLevel.find_by_name(d[i]) if !d[i].blank?
        end
        School.create(:name => d[0], :report_name => d[1], :service_levels => levels)
      end
    end

    def self.segments(file)
      data = FasterCSV.read(file, CSV_OPTIONS)
      data.each do |d|
        next if d[0] == 'Nome'
        level = ServiceLevel.find_by_name(d[1])
        Segment.create(:name => d[0], :service_level_id => level.id)
      end
    end

    def self.dimensions(file)
      data = FasterCSV.read(file, CSV_OPTIONS)
      data.each do |d|
        next if d[0] == 'Nome'
        level = ServiceLevel.find_by_name(d[2])
        Dimension.create(:name => d[0], :number => d[1], :service_level_id => level.id)
      end
    end

    def self.indicators(file)
      data = FasterCSV.read(file, CSV_OPTIONS)
      data.each do |d|
        next if d[0] == 'Nome'
        level = ServiceLevel.find_by_name(d[4])
        dimension = Dimension.find_by_number_and_service_level_id(d[3], level.id)
        
        if d[2].include?(".")
          indicator_number = d[2].split(".").last
        else
          indicator_number = d[2]
        end
        Indicator.create(:name => d[0], :description => d[1],:number => indicator_number, :dimension_id => dimension.id)
      end
    end
    
  end

end