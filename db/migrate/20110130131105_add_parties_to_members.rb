class AddPartiesToMembers < ActiveRecord::Migration
  def self.up
    add_column :questions, :questions_party_id, :integer
    add_column :indicators, :indicators_party_id, :integer
  end

  def self.down
  end
end
