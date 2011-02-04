class User < ActiveRecord::Base
  has_many :answers
  has_many :attendees
  belongs_to :institution
  belongs_to :segment
  belongs_to :service_level
  belongs_to :group

  accepts_nested_attributes_for :attendees

  named_scope :by_service_level, proc{|level| {:conditions => ["service_level_id = ?", level.id]}}
end
