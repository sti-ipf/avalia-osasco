class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.integer :party_id
      t.references :member, :polymorphic => true

      t.timestamps
    end
  end

  def self.down
    drop_table :memberships
  end
end
