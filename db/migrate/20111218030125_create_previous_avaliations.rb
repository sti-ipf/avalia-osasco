class CreatePreviousAvaliations < ActiveRecord::Migration
  def self.up
    create_table :previous_avaliations do |t|
      t.string :year
      t.references :school
      t.string :school_name
      t.references :service_level
      t.references :dimension
      t.string :indicator_number
      t.float :media
      t.float :professores
      t.float :familiares
      t.float :funcionarios
      t.float :gestores
      t.float :educandos

      t.timestamps
    end
  end

  def self.down
    drop_table :previous_avaliations
  end
end
