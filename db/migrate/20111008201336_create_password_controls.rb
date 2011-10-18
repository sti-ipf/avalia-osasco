class CreatePasswordControls < ActiveRecord::Migration
  def self.up
    create_table :password_controls do |t|
      t.references :school
      t.references :service_level
      t.integer :passwords_total
      t.references :segment

      t.timestamps
    end
  end

  def self.down
    drop_table :password_controls
  end
end
