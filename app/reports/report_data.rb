# encoding: UTF-8
require 'ostruct'

class ReportData

  attr_reader :dimensions_sl
  attr_reader :dimensions_group

  attr_accessor :institution
  attr_accessor :service_level

  def initialize(institution,service_level)
    @institution = institution
    @service_level = service_level

    @dimensions_sl = {}
    @dimensions_group = {}

    begin
      first_user = @institution.users.first(:conditions => {:service_level_id => @service_level.id}, :include => :group)
      @group = first_user.group
    rescue
      puts "#{@institution.name} does not have a user in service level #{@service_level.name}"
    end
  end

  def questions_party_table_burjato(questions_party)
    data = [["Segmento", "Nº da questão do segmento", " Média por Segmento", "Média Geral da Questão"]]

    segments_strings = %W(Familiares Funcionários Gestores)

    segments =  segments_strings.map { |sname| Segment.first(:conditions => {:name => sname}) }.compact

    psegment = segments.select { |s| s.name == "Gestores" }.first
    questions_party = QuestionsParty.find(questions_party, :include => {:questions => :indicator})
    display_question = questions_party.questions.first(:include => [:survey], :conditions => ["surveys.segment_id = ?", psegment.id])
    display_question ||= questions_party.questions.first(:conditions => "description is not null")

    segments.each_with_index do |segment, i|
      question = questions_party.questions.first(:include => [:survey], :conditions => ["surveys.segment_id = ?", segment.id])
      row = [segment.name]
      row << (question.nil? ? "-" : question.number)

      if question.present?
        answers = question.answers.with_institution(@institution).by_service_level(service_level).min_participants(0).newer
        current_answer = (answers.map(&:mean).first.nil?)? "NR": answers.map(&:mean).avg.to_f.round(2)
        row << current_answer
      else
        row << "-"
      end

      if i == 1
        answers = questions_party.questions.map {|q| q.answers.with_institution(@institution).by_service_level(service_level).min_participants(0).newer}.compact
        mean = []
        answers.each do |a|
          mean << a.map(&:mean)
        end
        row << mean.collect{|i| i.avg}.avg.to_f.round(2)
      else
        row << ""
      end
      data << row
    end
    description = display_question.description if display_question
    description ||= ""
    description =  description.gsub(/^[0-9]+\.[0-9]+\.[0-9]+/,'')
    {
      :description => description,
      :table => data
    }
  end

  def dimension_graph(dimension)
    graph_start_time = now = Time.now

    data_sl = Institution.mean_dimension_by_sl(dimension, @service_level)
    #p data_sl
    sl_time = Time.now - now
    now = Time.now
    # p data_sl

    p "Graph Dimension: #{dimension.number}. #{dimension.name}"

    group = @institution.users.first(:conditions => {:service_level_id => @service_level.id}, :include => :group).group
    data_group = Institution.mean_dimension_by_group(dimension, @service_level, group)
    #p data_group
    group_time = Time.now - now
    now = Time.now

    data = @institution.mean_dimension(dimension, @service_level)
    #p data
    dimension_time = Time.now - now
    now = Time.now
    graph = @institution.graph(data, data_group, data_sl, @service_level, :id => dimension.number)
    p_times(graph, :sl => sl_time, :group => group_time, :dimension => dimension_time, :graph => Time.now - now, :total => Time.now - graph_start_time)

    graph
  end

  def service_level_graph(dimension)
    graph_start_time = now = Time.now
    data_service_level = {}
    @institution.service_levels.each do |service_level|
      service_level_average_data = Institution.mean_dimension_by_sl(dimension, service_level)
      data_service_level[service_level.name] = service_level_average_data.reject{|k,v| k == :mean}
    end
    service_level_time = Time.now - now

    now = Time.now
    p "Graph Service Level Dimension: #{dimension.number}. #{dimension.name}"
    dimension_time = Time.now - now

    now = Time.now
    graph = @institution.service_level_graph(data_service_level, @service_level, :id => dimension.number)
    graph_time = Time.now - now

    p_times(graph, :sl => service_level_time, :dimension => dimension_time, :graph => graph_time, :total => Time.now - graph_start_time)
  end

  def indicators_graph(dimension)
    indicators_parties = dimension.indicators_parties.all(:conditions => {:service_level_id => @service_level.id})
    filenames = indicators_parties.inject([]) do |list, indicators_party|
      list << indicator_graph(indicators_party)
    end
  end

  def indicator_graph(indicators_party)
    now = graph_start_time = Time.now
    data_sl = Institution.mean_indicator_by_sl(indicators_party, @service_level)
    #p data_sl
    sl_time = Time.now - now
    now = Time.now

    data_group = Institution.mean_indicator_by_group(indicators_party,@service_level, @group)
    #p data_group
    group_time = Time.now - now

    now = Time.now
    data = @institution.mean_indicator(indicators_party,@service_level)
    #p data
    indicators = {}
    indicators_party.indicators.each do |i|
      indicators[i.segment.name] = i.number
    end
    graph = @institution.graph(data, data_group, data_sl, @service_level, :id => "i#{indicators_party.id}", :title => "#{indicators_party.indicators.first.name}", :indicators => indicators)
    now2 = Time.now

    p_times(graph, :sl => sl_time, :group => group_time, :graph => now2 - now, :total => now2 - graph_start_time)
    #p "=============================================================================================================="
    graph
  end

  def p_times(filename, times={})
    t = []
    times.to_a.reverse.each do |k, v|
      t << ("%s: %0.3f" % [k, v])
    end
    p "Generated #{File.basename(filename)} (#{t.join(", ")})"
  end

  def index_table_burjato
    means = {}
    dimensions = @service_level.id == 2 ? (1..11) : (1..10)

    dimensions.each do |dim|
      d = Dimension.find_by_number(dim)

      data = @institution.mean_dimension(d,@service_level)
      means[d.id] = data
    end
    # Fabrício - inserindo dados da dimensão 11 para o Burjato, que não é respondida
    means[12] = {:mean=>0, :segments=>{"Familiares"=>0, "Funcionarios"=>0, "Gestores"=>0}} if @service_level.id == 5
    @institution.grade_to_table_burjato(means,@service_level)
  end

  def service_level_group_table(service_level)
    members_groups = {
    "Creche" => [["grupo 1","grupo 2","grupo 3","grupo 4"],["Creche Benedita de Oliveira","Creche Elza Batiston","Creche Vilma Catan","Creche Amélia Tozzeto"],["CEMEI Lourdes Candida","Creche Sadamitu Omosako","Creche Maria José da Anunciação","Creche José Espinosa"],["CEMEI Wilma Foltran","Creche Prof. Silvia Ferreira Farhat","Creche Seraphina Bissolati","Creche Alha Elias Abib"],["CEMEIEF Maria José Ferreira Ferraz","CEU Zilda Arns","CEMEIEF Maria Tarsilla","Creche Giuseppa"],["CEMEI Rubens Bandeira","Creche Alzira Silva","Creche Lar da Infância","CEMEI José Ermírio"],["CEMEI João de Farias","Creche Olga Camolesi","Creche Pedro Penov","CEMEI Mário Quintana"],["Creche Prof. Joaquina França","CEMEI Leonil Crê","Creche Hermínia Lopes","Creche Mercedes Correa"], ["CEMEI Fortunato Antiório","Creche Rosa Broseguini","Creche Hilda","Creche Dayse Ribeiro"],["CEMEI Mário Sebastião","Creche Olímpia","Creche Rosa Pereira Crê","Creche Sergio Zanardi"],["CEMEIEF Darcy Ribeiro","Creche Ézio Melli","Creche Lídia Thomaz","Cemei Zaira Colino"],["  ","  ","Creche João Correa","Creche Recanto Alegre"],["  ","  ","Creche Ida Belmonte","CEMEI Alberto Santos Dumont"],["  ","  "," ","Creche Inês Sanches Mendes"],["  ","  "," ","Creche Irmã B. Constâncio e Creche Moacyr Ayres"]],

    "EMEI" => [["grupo 1","grupo 2","grupo 3","grupo 4"],["EMEI Maria Bertoni Fiorita","EMEI Maria Alves Dória","EMEI Helena Coutinho","CEMEI Zaíra Collino"],["EMEI Omar Ogeda","EMEI Nair Bellacoza","EMEI Pedro Martino","EMEI Cristine"],["EMEI Japhet Fontes","EMEIEF Valter de Oliveira","EMEI Maria Madalena Freixeda","CEMEI Alberto Santos Dumont"],["CEMEI Lourdes Candida","CEU Zilda Arns","EMEI Alípio Pereira","EMEI Osvaldo Salles"],["CEMEI Wilma Foltran","EMEI Gertrudes de Rossi","EMEI Estevão Brett","EMEI Esmeralda"],["EMEI Osvaldo Gonçalves","CEMEI Leonil Crê","CEMEIEF Maria Tarcilla","EMEIEF Messias"],["EMEI Yolanda Botaro","EMEI Sonia Maria ","EMEI Dalva Mirian","EMEI Emir Macedo"], ["CEMEI Fortunato Antiório","EMEI Maria Ap. Damy","EMEI Fernando Buonaduce","EMEI Descio Mendes"],["CEMEI Mário Sebastião","EMEIEF Colinas D Oeste","EMEI Alice Manholer Pitteri","EMEIEF Zuleika"],["CEMEIEF Darcy Ribeiro","  ","EMEI Fortunata","CEMEI José Emírio"],["EMEI Vivaldo","  ","EMEI Elide Alves","CEMEI Mário Quintana"],["CEMEIEF Maria José Ferreira Ferraz","  ","EMEI Adhemar Pereira","EMEI Salvador Sacco"],["CEMEI Rubens Bandeira","  ","EMEIF Etiene","EMEI Adelaide Dias"],["CEMEI João de Farias"," ","EMEI Providencia dos Anjos"," "],["EMEI José Flávio","  ","EMEI Ignes Collino","  "],["EMEIEF Elio Aparecido da Silva","  ","EMEI Severino","  "],["  ","  ","EMEI Luzia Momi Sasso","  "],["  ","  ","EMEI Antonio Paulino","  "],["  ","  ","EMEI Thereza Bianchi Colino","  "]],

    "EMEF" => [["grupo 1","grupo 2","grupo 3","grupo 4"],["Unidades Educacionais que não atingiram a meta projetada para ela em 2007 e apresentam IDEB inferior ao da rede municipal.","Unidades Educacionais que atingiram ou ultrapassaram a meta projetada para ela em 2007 mas mantiveram o seu IDEB inferior ao da rede municipal.","Unidades Educacionais que não atingiram a meta projetada para ela em 2007 e apresentaram IDEB igual ou superior ao da rede municipal.","Unidades Educacionais que atingiram ou ultrapassaram a meta projetada para ela em 2007 e apresentaram IDEB igual ou superior ao da rede municipal"]]
    }
    name = service_level.name.upcase
    {:title => name == "CRECHE" ? name + "S" : name + "s", :table => members_groups[service_level.name] }
  end

  def single_institution_dimension_graph(dimension)
    graph_start_time = now = Time.now

    #data_sl = Institution.mean_dimension_by_sl(dimension, @service_level)
    #p data_sl
    sl_time = Time.now - now
    now = Time.now
    # p data_sl

    p "Single Institution Dimension Graph : #{dimension.number}. #{dimension.name}"

    #group = @institution.users.first(:conditions => {:service_level_id => @service_level.id}, :include => :group).group
    #data_group = Institution.mean_dimension_by_group(dimension, @service_level, group)
    #p data_group
    #group_time = Time.now - now
    #now = Time.now

    data = @institution.mean_dimension(dimension, @service_level)
    #p data
    dimension_time = Time.now - now
    now = Time.now
    graph = @institution.single_institution_graph(data, @service_level, :id => "#{dimension.number}")
    p_times(graph, :dimension => dimension_time, :graph => Time.now - now, :total => Time.now - graph_start_time)

    graph
  end

  def single_institution_indicators_graph(dimension)

    indicators_parties = dimension.indicators_parties.all(:conditions => {:service_level_id => @service_level.id})
    filenames = indicators_parties.inject([]) do |list, indicators_party|
      list << single_institution_indicator_graph(indicators_party)
    end
  end

  def single_institution_indicator_graph(indicators_party)
    now = graph_start_time = Time.now
    #data_sl = Institution.mean_indicator_by_sl(indicators_party, @service_level)
    #p data_sl
    sl_time = Time.now - now
    now = Time.now

    #data_group = Institution.mean_indicator_by_group(indicators_party,@service_level, @group)
    #p data_group
    #group_time = Time.now - now

    now = Time.now
    data = @institution.mean_indicator(indicators_party,@service_level)
    #p data
    indicators = {}
    indicators_party.indicators.each do |i|
      indicators[i.segment.name] = i.number
    end
    title = indicators_party.indicators.first.name ||  indicators_party.indicators.first.number
    graph = @institution.single_institution_graph(data, @service_level, :id => "i#{indicators_party.id}", :title => "#{title}", :indicators => indicators)
    now2 = Time.now

    p_times(graph,  :graph => now2 - now, :total => now2 - graph_start_time)
    graph
  end
end

