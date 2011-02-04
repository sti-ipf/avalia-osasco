class CreateQuestionsParties < ActiveRecord::Migration
  def self.up
    create_table :questions_parties do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :questions_parties
  end
end
