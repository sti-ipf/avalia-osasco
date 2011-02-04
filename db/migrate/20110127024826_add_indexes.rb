class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :questions, :survey_id
    add_index :questions, :number
    add_index :users, :service_level_id
    add_index :users, :institution_id
    add_index :users, :group_id
    add_index :answers, :survey_id
    add_index :answers, :question_id
    add_index :answers, :survey_id
  end

  def self.down
  end
end
