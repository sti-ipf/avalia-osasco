class Indicator < ActiveRecord::Base
  belongs_to :dimension
  belongs_to :service_level
  belongs_to :segment
  belongs_to :indicators_party

  has_many :questions
  has_many :questions_parties, :through => :questions, :uniq => true

  named_scope :by_service_level, proc {|sl| {:conditions => ["service_level_id = ?", sl.kind_of?(ServiceLevel) ? sl.id : sl]}}
  named_scope :by_segment, proc {|segment| {:conditions => ["segment_id = ?", segment.kind_of?(Segment) ? segment.id : segment]}}
  named_scope :by_dimension, proc {|dimension| {:conditions => ["dimension_id = ?", dimension.kind_of?(Dimension) ? dimension.id : dimension]}}

  def self.by_service_level_and_segments(service_level,segment)
    # Indicator.all :conditions => "service_level_id = #{service_level.id} AND segment_id = #{segment.id}"
    by_service_level(service_level).by_segment(segment)
  end

  def colleagues
    # group = []
    # indicators_party.indicators.each do |i|
    #   group << i unless i == self
    # end unless indicators_party.nil?
    # group
    return [] if indicators_party.nil?
    indicators_party.indicators.all(:conditions => ["id != ?", id])
  end

  def self.by_dimension_and_service_level(dimension_id,service_level_id)
    # Indicator.all :conditions => "dimension_id = #{dimension_id} AND service_level_id = #{service_level_id}"
    by_dimension(dimension_id).by_service_level(service_level_id)
  end

end

