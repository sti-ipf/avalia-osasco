class AddServiceLevelToIndicators < ActiveRecord::Migration
  def self.up
    add_column :indicators, :service_level_id, :integer
  end

  def self.down
    remove_column :indicators, :service_level_id
  end
end
