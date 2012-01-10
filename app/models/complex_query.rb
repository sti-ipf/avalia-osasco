class ComplexQuery < ActiveRecord::Base

	def self.get_total_schools_started_answer
		result = self.connection.execute("select count(*) from schools s, (select school_id, count(*) dimensions from dimension_statuses group by school_id) ds where s.id = ds.school_id")
		if result.entries.nil?
			[0]
		else
			result.entries[0]
		end
	end

	def self.get_total_schools_started_answer_by_service_level(service_level_id)
		result = self.connection.execute("
			select count(*) from dimension_statuses where segment_id IN (select id from segments where service_level_id = #{service_level_id}) group by school_id
			")
		if result.entries.nil?
			[0]
		else
			result.entries.count
		end
	end

	def self.get_total_started_answer_by_service_level_and_segment_and_dimension_id(servicel_level_id, segment, dimension_id)
		result = self.connection.execute("
			select * from dimension_statuses ds
			where segment_id IN (select id from segments where service_level_id = #{servicel_level_id} 
			and name like '#{segment}') and dimension_id = #{dimension_id}
			")
		if result.entries.nil?
			[0]
		else
			result.entries.count
		end	
	end

	def self.get_schools_status_data(schools, segments)
		result = []
		schools.each do |school|
			school.service_levels.each do |sl|
				data = []
				data << "#{sl.name} - #{school.name}"
				segments.each do |segment|
					total = sl.dimensions.count
					seg = Segment.first(:conditions => "name = '#{segment}' AND service_level_id = #{sl.id}")
					if seg.nil?
						value = '-'
					else
						status = DimensionStatus.last(:conditions => "segment_id = #{seg.id} AND school_id = #{school.id}")
						if status.nil?					
							value = 0
						else
							value = percentage_value(status.dimension.number, total)
						end
					end
					data << value
				end
			result << data
			end
		end
		result
	end

private
	
	def self.percentage_value(dimension, total)
		value = (dimension * 100)/total
	end

end
