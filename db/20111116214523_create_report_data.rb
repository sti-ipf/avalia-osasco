class CreateReportData < ActiveRecord::Migration
  def self.up
    create_table :report_data do |t|
      t.float :media
      t.string :answers_ids
      t.references :indicator
      t.references :segment
      t.references :dimension
      t.references :school
      t.references :service_level

      t.timestamps
    end
  end

  def self.down
    drop_table :report_data
  end
end
