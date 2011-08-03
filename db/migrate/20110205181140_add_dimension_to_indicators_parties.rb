class AddDimensionToIndicatorsParties < ActiveRecord::Migration
  def self.up
    add_column :indicators_parties, :dimension_id, :integer
    p "Atualizando um total de #{IndicatorsParty.count} IndicatorsParties"
    IndicatorsParty.all.each do |indicator_party|
      p "Atualizando IndicatorsParty com o id #{indicator_party.id}"
      indicator_party.dimension = indicator_party.indicators.first.dimension unless indicator_party.indicators.empty?
      indicator_party.save!
    end
  end

  def self.down
    remove_column :indicators_parties, :dimension_id
  end
end