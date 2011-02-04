class Membership < ActiveRecord::Base
  belongs_to :member, :polymorphic => true
  belongs_to :party
 
  def self.members(party)
    Membership.all :conditions => "party_id = #{party.id}"
  end
end
