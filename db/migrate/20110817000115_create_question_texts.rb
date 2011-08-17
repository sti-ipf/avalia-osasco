class CreateQuestionTexts < ActiveRecord::Migration
  def self.up
    create_table :question_texts do |t|
      t.string :text
      t.integer :question_id
      t.integer :segment_id

      t.timestamps
    end
  end

  def self.down
    drop_table :question_texts
  end
end
