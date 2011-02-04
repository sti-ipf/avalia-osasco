class AddMerbershipToIndicators < ActiveRecord::Migration
  def self.up
    add_column :indicators, :membership_id, :integer
  end

  def self.down
    remove_column :indicators, :membership_id
  end
end
