class CreateDimensionStatuses < ActiveRecord::Migration
  def self.up
    create_table :dimension_statuses do |t|
      t.integer :status
      t.integer :dimension_id
      t.integer :school_id
      t.integer :segment_id

      t.timestamps
    end
  end

  def self.down
    drop_table :dimension_statuses
  end
end
