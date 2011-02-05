class Dimension < ActiveRecord::Base
  has_many :indicators
  has_many :indicators_parties
  
  def find_by_number(number)
    Rails.cache.fetch("dimension-#{number}") { all(:conditions => "number = #{number}").first }
  end

  def to_s
    "#{number} - #{name}"
  end
end
