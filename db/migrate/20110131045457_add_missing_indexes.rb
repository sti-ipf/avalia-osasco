class AddMissingIndexes < ActiveRecord::Migration
  def self.up
    add_index :answers, :user_id
    add_index :answers, :participants_number
    add_index :answers, :created_at
    
    add_index :dimensions, :number
    
    Answer.delete_all("user_id = 171")
  end

  def self.down
    remove_index :dimensions, :number
    remove_index :answers, :created_at
    remove_index :answers, :participants_number
    remove_index :answers, :user_id
  end
end