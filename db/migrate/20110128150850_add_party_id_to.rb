class AddPartyIdTo < ActiveRecord::Migration
  def self.up
    add_column :questions, :party_id, :integer 
  end
  
  def self.down
    remove_column :questions, :party_id
  end
end
