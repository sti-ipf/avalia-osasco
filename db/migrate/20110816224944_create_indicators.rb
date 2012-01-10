class CreateIndicators < ActiveRecord::Migration
  def self.up
    create_table :indicators do |t|
      t.string :name
      t.string :description
      t.integer :number
      t.integer :dimension_id

      t.timestamps
    end
  end

  def self.down
    drop_table :indicators
  end
end
