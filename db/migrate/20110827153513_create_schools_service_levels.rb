class CreateSchoolsServiceLevels < ActiveRecord::Migration
  def self.up
    #create_table :service_levels_schools do |t|
    #  t.integer :service_level_id
    #  t.integer :school_id

    #  t.timestamps
    create_table :schools_service_levels, :id => false do |t|
        t.references :service_level, :null => false
        t.references :school, :null => false
    end
  end

  def self.down
    drop_table :schools_service_levels
  end
end

