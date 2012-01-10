class CreateDimensionData < ActiveRecord::Migration
  def self.up
    create_table :dimension_data do |t|
      t.references :school
      t.references :service_level
      t.integer :dimension_number
      t.string :indicator_number
      t.integer :year
      t.float :value

      t.timestamps
    end
  end

  def self.down
    drop_table :dimension_data
  end
end
