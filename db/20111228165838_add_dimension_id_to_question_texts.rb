class AddDimensionIdToQuestionTexts < ActiveRecord::Migration
  def self.up
    add_column :question_texts, :dimension_id, :integer
  end

  def self.down
    remove_column :question_texts, :dimension_id
  end
end


