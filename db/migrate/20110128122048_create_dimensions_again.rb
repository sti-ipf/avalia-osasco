class CreateDimensionsAgain < ActiveRecord::Migration
  def self.up
    add_column :dimensions, :number, :integer
  end

  def self.down
    remove_column  :dimensions, :number
  end
end
