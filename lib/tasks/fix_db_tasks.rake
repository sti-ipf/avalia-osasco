namespace :fix_db do
  desc "Add indicators id in question rows"
  task :fix_indicators_id_from_questions => :environment do
    p "Corrigindo indicator_id para todas as questions..."
    Indicator.all.each do |ind|
      sl        = ind.service_level.id
      seg       = ind.segment.id
      number    = ind.number
      survey    = Survey.find(:first, :conditions => {:service_level_id => sl, :segment_id => seg})
      questions = survey.questions.find(:all, :conditions => ["number like ?", "#{number}.%"])
      questions.each {|question| question.update_attribute(:indicator_id, ind.id)}
    end
    p "Correção concluída!"
  end

  desc "create indicators_party from Ensino Funcamental"
  task :create_indicators_party => :environment do
    SEGMENTS=['Professores','Gestores','Funcionarios','Familiares','Educandos']

    f = File.new('lib/csv/indicators_parties_emei.csv','r')
    parties = []

    while line = f.gets
      parties << line.split(',')
    end

    sl = ServiceLevel.find(4) #creche

    parties.each do |party|
      p = IndicatorsParty.create!
      inds = Indicator.all

      p party.inspect

      (0..(party.size - 1)).each do |i|
        selected_inds = (inds.select { |ind| ind.segment.name == SEGMENTS[i] && ind.service_level == sl })
        ind = (selected_inds.select { |ind| ind.number == party[i].gsub(/\n/,'').gsub(/\.$/,'') }).first
        p ind
        unless ind.nil?
          ind.indicators_party_id = p.id
          ind.save!
        end
      end
    end
  end

  task :create_questions_party => :environment do
    SEGMENTS=['Professores','Gestores','Funcionarios','Familiares','Educandos']

    f = File.new('lib/csv/questions_parties_emef.csv','r')
    parties = []

    while line = f.gets
      parties << line.split(',')
    end

    parties.each do |party|
      p = QuestionsParty.create!

      p party.inspect

      (0..(party.size - 1)).each do |i|
        question_number = party[i].gsub(/\n/,'').gsub(/\.$/,'')
        sql = "SELECT q.id, q.survey_id, q.questions_party_id, q.indicator_id FROM questions q JOIN surveys s ON s.id = q.survey_id JOIN segments seg ON seg.id = s.segment_id JOIN service_levels sl ON sl.id = s.service_level_id  WHERE seg.name = '#{SEGMENTS[i]}' AND sl.id = 2 AND q.number LIKE '#{question_number}'"
        ind = Question.find_by_sql(sql).first
        p ind.inspect
        unless ind.nil?
          p.indicators_party = ind.indicator.indicators_party
          p.save!
          ind.questions_party_id = p.id
          ind.save!
        end
        p "QUestion=>#{ind.inspect}"
        p "QUestionParty=>#{p.inspect}"
      end
    end
  end

  task :update_indicators_party => :environment do
    IndicatorsParty.all.each do |ip|
      unless ip.indicators.empty?
        ip.dimension_id = ip.indicators.first.dimension.id
        ip.service_level_id = ip.indicators.first.service_level.id
        ip.save!
      end
    end
  end

  desc "create indicators_party from Educação Especial"
  task :create_indicators_party_from_ee => :environment do
    SEGMENTS=['Funcionarios','Gestores','Familiares']

    f = File.new('lib/csv/indicators_parties_educacao_especial.csv','r')
    parties = []

    while line = f.gets
      parties << line.split(',')
    end

    sl = ServiceLevel.find(5) #educacao especial

    parties.each do |party|
      p = IndicatorsParty.create!
      inds = Indicator.all

      p "party => #{party.inspect}"

      (0..(party.size - 1)).each do |i|
        indicator_number = party[i].gsub(/\n/,'').gsub(/\.$/,'')
        unless indicator_number.empty?
          dimension_number = indicator_number.split('.').first
          dimension        = Dimension.find_by_number(dimension_number)
          segment          = Segment.find_by_name(SEGMENTS[i])
          params           = {
            :dimension_id => dimension.id,
            :number => indicator_number,
            :service_level_id => sl,
            :segment_id => segment.id
          }
        end
        ind = Indicator.find(:first, :conditions => params)
        ind = Indicator.create!(params) unless ind

        # unless ind.nil?
          ind.indicators_party_id = p.id
          ind.save!
          p "indicator2 => #{ind.inspect}"
        # end
      end
    end
  end


  task :create_questions_party_from_ee => :environment do
    SEGMENTS=['Funcionarios','Gestores','Familiares']

    f = File.new('lib/csv/questions_parties_educacao_especial.csv','r')
    parties = []

    while line = f.gets
      parties << line.split(',')
    end

    parties.each do |party|
      p = QuestionsParty.create!

      p "QUESTIONPARTY empty=>#{p.inspect}"

      (0..(party.size - 1)).each do |i|
        question_number = party[i].gsub(/\n/,'').gsub(/\.$/,'')
        sql = "SELECT q.id, q.survey_id, q.questions_party_id, q.indicator_id FROM questions q JOIN surveys s ON s.id = q.survey_id JOIN segments seg ON seg.id = s.segment_id JOIN service_levels sl ON sl.id = s.service_level_id  WHERE seg.name = '#{SEGMENTS[i]}' AND sl.id = 5 AND q.number LIKE '#{question_number}'"
        p sql
        ind = Question.find_by_sql(sql).first
        p "QUESTION=>#{ind.inspect}"
        unless ind.nil?
          p.indicators_party = ind.indicator.indicators_party if ind.indicator
          p.save!
          ind.questions_party_id = p.id
          ind.save!
        end
        p "QUestion=>#{ind.inspect}"
        p "QUestionParty populate=>#{p.inspect}"
      end
    end
  end

end