class CreateComplexQueries < ActiveRecord::Migration
  def self.up
    create_table :complex_queries do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :complex_queries
  end
end
