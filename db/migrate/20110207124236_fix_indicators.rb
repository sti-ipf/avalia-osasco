class FixIndicators < ActiveRecord::Migration
  def self.up
    q = Question.find(2054)
    q.indicator_id = 573
    q.save!

    i = Indicator.new
    i.indicators_party_id = 34
    i.number = '5.4'
    i.name = 'Preocupação com o abandono e evasão'
    i.dimension_id = 6
    i.service_level_id = 2
    i.segment_id = 2
    i.save!
    q = Question.find(1896)
    q.indicator_id = i.id
    q.save!
    q = Question.find(3043)
    q.indicator_id = i.id
    q.save!

    i = Indicator.new
    i.indicators_party_id = 70
    i.number = '2.4'
    i.name = 'Espaços, materiais e mobiliários para responder aos interesses e necessidades dos adultos'
    i.dimension_id = 3
    i.service_level_id = 3
    i.segment_id = 3
    i.save!
    q = Question.find(2298)
    q.indicator_id = i.id
    q.save!
    q = Question.find(2299)
    q.indicator_id = i.id
    q.save!
    q = Question.find(2300)
    q.indicator_id = i.id
    q.save!

    i = Indicator.new
    i.indicators_party_id = 66
    i.number = '1.11'
    i.name = 'Respeito ao Ritmo das Crianças'
    i.dimension_id = 1
    i.service_level_id = 3
    i.segment_id = 4
    i.save!
    q = Question.find(171)
    q.indicator_id = i.id
    q.save!
    q = Question.find(172)
    q.indicator_id = i.id
    q.save!
  end

  def self.down
  end
end
