module EvaluationHelper
	def last_dimension
		dimensions = Dimension.where("service_level_id = ?", @service_level.id).order("number")
		@dimension.number == dimensions.last.number
	end
end
