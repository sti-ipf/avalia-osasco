class CreatePractices < ActiveRecord::Migration
  def self.up
    create_table :practices do |t|
      t.string :consolidated
      t.string :to_be_improved
      t.integer :dimension_id
      t.integer :school_id
      t.integer :segment_id

      t.timestamps
    end
  end

  def self.down
    drop_table :practices
  end
end
