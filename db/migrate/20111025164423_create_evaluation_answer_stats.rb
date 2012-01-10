class CreateEvaluationAnswerStats < ActiveRecord::Migration
  def self.up
    create_table :evaluation_answer_stats do |t|
      t.integer :service_level_id
      t.integer :segment_id
      t.integer :school_id
      t.boolean :started_to_answer
      t.datetime :started_at
      t.datetime :finished_at
      t.integer :dimension_id

      t.timestamps
    end
  end

  def self.down
    drop_table :evaluation_answer_stats
  end
end
