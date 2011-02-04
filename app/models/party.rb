class Party < ActiveRecord::Base
  has_many :memberships
  
  accepts_nested_attributes_for :memberships
  
end
