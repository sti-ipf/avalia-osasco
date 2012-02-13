class CreateGeneralReportData < ActiveRecord::Migration
  def self.up
    create_table :general_report_data do |t|
      t.float :media
      t.references :indicator
      t.references :segment
      t.references :dimension
      t.integer :data_type
      t.references :service_level
      t.integer :year
      t.timestamps
    end
  end

  def self.down
    drop_table :general_report_data
  end
end
