class AddMerbershipToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :membership_id, :integer
  end

  def self.down
    remove_column :questions, :membership_id
  end
end
