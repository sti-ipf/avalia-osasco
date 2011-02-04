class CreateIndicatorsParties < ActiveRecord::Migration
  def self.up
    create_table :indicators_parties do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :indicators_parties
  end
end
