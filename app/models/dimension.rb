class Dimension < ActiveRecord::Base
  has_many :indicators
  has_many :indicators_parties
  named_scope :infantil, :conditions => "number IN (#{(1..10).collect.join(',')})"
  named_scope :fundamental, :conditions => "number IN (#{(1..11).collect.join(',')})"

  def find_by_number(number)
    Rails.cache.fetch("dimension-#{number}") { all(:conditions => "number = #{number}").first }
  end

  def to_s
    "#{number} - #{name}"
  end
end

