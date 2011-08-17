class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.integer :number
      t.integer :service_level_id
      t.integer :indicator_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
