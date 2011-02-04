class ReplaceNumberTypeOnIndicators < ActiveRecord::Migration
  def self.up
    change_column :indicators, :number, :string
  end

  def self.down
    change_column :indicators, :number, :integer
  end
end
