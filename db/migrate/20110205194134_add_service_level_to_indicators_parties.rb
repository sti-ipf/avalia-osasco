class AddServiceLevelToIndicatorsParties < ActiveRecord::Migration
  def self.up
    add_column :indicators_parties, :service_level_id, :integer
    p "Atualizando um total de #{IndicatorsParty.count} IndicatorsParties"
    IndicatorsParty.all.each do |indicator_party|
      p "Atualizando IndicatorsParty com o id #{indicator_party.id}"
      indicator_party.service_level = indicator_party.indicators.first.service_level unless indicator_party.indicators.empty?
      indicator_party.save!
    end
  end

  def self.down
    remove_column :indicators_parties, :service_level_id
  end
end