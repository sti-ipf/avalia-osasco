class ServiceLevel < ActiveRecord::Base
  has_and_belongs_to_many :institutions
  has_and_belongs_to_many :segments
  has_many :users

  def to_s
    name
  end

end

