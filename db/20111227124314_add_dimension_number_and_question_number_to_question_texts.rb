class AddDimensionNumberAndQuestionNumberToQuestionTexts < ActiveRecord::Migration
  def self.up
    add_column :question_texts, :dimension_number, :integer
    add_column :question_texts, :question_number, :string
  end

  def self.down
    remove_column :question_texts, :dimension_number
    remove_column :question_texts, :question_number
  end
end