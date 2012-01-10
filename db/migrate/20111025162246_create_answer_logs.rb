class CreateAnswerLogs < ActiveRecord::Migration
  def self.up
    create_table :answer_logs do |t|
      t.integer :service_level_id
      t.integer :segment_id
      t.integer :school_id
      t.integer :dimension_id
      t.string :person
      t.text :questions

      t.timestamps
    end
  end

  def self.down
    drop_table :answer_logs
  end
end
