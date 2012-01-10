class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.integer :do_not_know
      t.integer :do_not_answer
      t.integer :one
      t.integer :two
      t.integer :three
      t.integer :four
      t.integer :five
      t.integer :quantity_of_people
      t.integer :question_text_id
      t.integer :school_id
      t.integer :segment_id

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
