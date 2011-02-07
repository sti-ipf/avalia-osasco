class FixIndicatorsCreche < ActiveRecord::Migration
  def self.up
    i = Indicator.new
    i.indicators_party_id = 115
    i.number = '2.3'
    i.name = 'Materiais variados e acessíveis às crianças'
    i.dimension_id = 3
    i.service_level_id = 4
    i.segment_id = 5
    i.save!
    q = Question.find(2550)
    q.indicator_id = i.id
    q.save!
    q = Question.find(2551)
    q.indicator_id = i.id
    q.save!
    q = Question.find(2552)
    q.indicator_id = i.id
    q.save!

    i = Indicator.new
    i.indicators_party_id = 116
    i.number = '2.4'
    i.name = 'Espaços, materiais e mobiliários para responder aos interesses e necessidades dos adultos'
    i.dimension_id = 3
    i.service_level_id = 4
    i.segment_id = 5
    i.save!
    q = Question.find(2553)
    q.indicator_id = i.id
    q.save!
    q = Question.find(2554)
    q.indicator_id = i.id
    q.save!
    q = Question.find(2555)
    q.indicator_id = i.id
    q.save!
  end

  def self.down
  end
end
