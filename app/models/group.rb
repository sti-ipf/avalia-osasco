class Group < ActiveRecord::Base
  has_many :users
  has_many :service_levels, :through => :users, :uniq => true
  
  named_scope :by_service_level, proc { |sl| {:include => {:users => :service_levels}, :conditions => ["service_levels.id = ?", sl.id]} }

  accepts_nested_attributes_for :users

end
