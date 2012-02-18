class CreateIndicatorsAverageGeral < ActiveRecord::Migration
  def self.up
    create_table :indicators_average_geral do |t|
      t.integer :service_level_id
      t.integer :dimension_id
      t.integer :dimension_number
      t.integer :indicator_id
      t.integer :indicator_number
      t.float :value
      t.string :segment
      t.timestamps
    end
  end

  def self.down
    drop_table :indicators_average_geral
  end
end
