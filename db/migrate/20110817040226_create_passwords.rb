class CreatePasswords < ActiveRecord::Migration
  def self.up
    create_table :passwords do |t|
      t.string :password
      t.integer :school_id
      t.integer :segment_id
      t.integer :service_level_id

      t.timestamps
    end
  end

  def self.down
    drop_table :passwords
  end
end

