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

    f = File.new('lib/csv/indicators_parties_emef.csv','r')
    parties = []

    while line = f.gets
      parties << line.split(',')
    end

    sl = ServiceLevel.find(2) #emef
    
    IndicatorsParty.delete_all
    
    Indicator.all.each {|i| i.update_attribute(:indicators_party_id, nil)}

    parties.each do |party|
      p = IndicatorsParty.create!
      inds = Indicator.all

      p party.inspect
      
      (0..(party.size - 1)).each do |i|
        selected_inds = (inds.select { |ind| ind.segment.name == SEGMENTS[i] && ind.service_level == sl })
        ind = (selected_inds.select { |ind| ind.number == party[i].gsub(/\n/,'') }).first
        p ind
        unless ind.nil?
          ind.indicators_party_id = p.id
          ind.save!
        end
      end
    end
  end
  
end