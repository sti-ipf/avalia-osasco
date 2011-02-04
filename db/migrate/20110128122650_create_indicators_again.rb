class CreateIndicatorsAgain < ActiveRecord::Migration
  def self.up
    create_table :indicators do |t|
      t.integer :dimension_id
      t.integer :number
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :indicators
  end
end
