class CreateDimensions < ActiveRecord::Migration
  def self.up
    create_table :dimensions do |t|
      t.string :name
      t.string :description
      t.integer :number
      t.integer :service_level_id

      t.timestamps
    end
  end

  def self.down
    drop_table :dimensions
  end
end
