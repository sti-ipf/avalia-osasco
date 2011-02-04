class CreateGroups < ActiveRecord::Migration
  def self.up
    remove_column :institutions, :group_id
    add_column :users, :group_id, :integer
  end

  def self.down
    remove_column :groups, :group_id
    add_column :institutions, :group_id, :integer
  end
end
