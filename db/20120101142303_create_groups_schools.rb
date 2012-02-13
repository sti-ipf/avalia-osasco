class CreateGroupsSchools < ActiveRecord::Migration
  def self.up
    create_table :groups_schools, :id => false do |t|
      t.references :group, :null => false
      t.references :school, :null => false
    end
  end

  def self.down
    drop_table :groups_schools
  end
end
