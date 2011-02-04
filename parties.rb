
SEGMENTS=['Professores','Gestores','Funcionarios','Familiares','Educandos']

def create_parties
  f = File.new('ind_group_ei','r')
  parties = []

  while line = f.gets
    parties << line.split(',')
  end
  
  sl = ServiceLevel.find(4)
  
  parties.each do |party|
    return party if party.size < 4
    p = IndicatorsParty.create!
    inds = Indicator.all
    
    (0..3).each do |i|
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
