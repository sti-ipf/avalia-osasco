class Segment < ActiveRecord::Base
  has_and_belongs_to_many :service_levels
  has_many :users
  
  named_scope :by_name, proc { |name| {:conditions => ["name = ?", name]} }

  def self.find_by_name(name)
    Segment.by_name(name).first
  end
  
  def <=>(other)
    name <=> other.name
  end
end
