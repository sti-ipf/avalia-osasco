# -*- coding: utf-8 -*-
class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  belongs_to :question

  before_validation :default_values

  validates_presence_of :zero, :one, :two, :three, :four, :five, :participants_number
  
  named_scope :by_group, proc { |group| {:conditions => ["answers.user_id in (select u2.id from users as u2 where u2.group_id=?)", group.id]} }
  named_scope :by_service_level, proc { |sl| {:conditions => ["answers.user_id in (select u2.id from users as u2 where u2.service_level_id=?)", sl.id]} }
  named_scope :min_participants, proc { |number| {:conditions => ["answers.participants_number > ?", number]} }
  named_scope :newer, :order => "answers.created_at DESC"
  named_scope :with_valid_user, :include => :user, :conditions => ["users.id is not NULL"]

  def mean
    @mean || (zero + one*1 + two*2 + three*3 + four*4 + five*5).to_f/participants_number
  end

 protected
  def validate
    errors.add(:participants_number, 'A soma das respostas nao confere com o numero de participantes') if zero + one + two + three + four + five != participants_number
  end

  def default_values
    self.zero = 0 unless self.zero
    self.one = 0 unless self.one
    self.two = 0 unless self.two
    self.three = 0 unless self.three
    self.four = 0 unless self.four
    self.five = 0 unless self.five
  end


  def hash
    user_id.hash
  end
  
  def eql?(comparee)
    self == comparee
  end
  

  def ==(comparee)
    self.user_id == comparee.user_id
  end
end
