class CreateDimensionsAverageGeral < ActiveRecord::Migration
  def self.up
    create_table :dimensions_average_geral do |t|
      t.integer :service_level_id
      t.integer :dimension_id
      t.integer :dimension_number
      t.float :value

      t.timestamps
    end
  end

  def self.down
    drop_table :dimensions_average_geral
  end
end
