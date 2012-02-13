class CreateGeneralData < ActiveRecord::Migration
  def self.up
    create_table :general_data do |t|
      t.integer :service_level_id
      t.integer :dimension_number
      t.integer :indicator_number
      t.string :segment
      t.float :media

      t.timestamps
    end
  end

  def self.down
    drop_table :general_data
  end
end
