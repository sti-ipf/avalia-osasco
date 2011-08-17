class CreatePresences < ActiveRecord::Migration
  def self.up
    create_table :presences do |t|
      t.string :name
      t.integer :school_id
      t.integer :segment_id

      t.timestamps
    end
  end

  def self.down
    drop_table :presences
  end
end
