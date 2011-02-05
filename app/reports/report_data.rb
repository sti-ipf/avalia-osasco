# encoding: UTF-8
require 'ostruct'

class ReportData

  attr_reader :dimensions_sl
  attr_reader :dimensions_group

  attr_accessor :institution
  attr_accessor :service_level

  def initialize(i,sl)
    @institution = i
    @service_level = sl

    @dimensions_sl = {}
    @dimensions_group = {}

    begin
      first_user = @institution.users.first(:conditions => {:service_level_id => @service_level.id}, :include => :group)
      @group = first_user.group
    rescue
      puts "#{@institution.name} does not have a user in service level #{@service_level.name}"
    end
  end
  
  

  def indicator_table(indicator)
    require 'ruport'

    data = []
    # header = ["Segmento", "Questao", "Media por Segmento", "Media da Questao", "Media do Grupo", "Media da Rede*"] # Header
    segments = Rails.cache.fetch("all-valid-segments") { %W(Professores Gestores Educandos Funcionarios Familiares).map { |sname| Segment.first(:conditions => {:name => sname}) }.compact }
    questions_party = QuestionsParty.first(:include => {:questions => :indicator}, :conditions => ["indicators.id = ?", indicator.id])
    # group = @institution.groups.first(:include => [:service_levels], :conditions => {:service_levels => {:id => @service_level.id}})
    psegment = segments.select { |s| s.name == "Professores" }

    display_question = questions_party.questions.first(:include => [:survey], :conditions => ["surveys.segment_id = ?", psegment.first.id])
    display_question ||= questions_party.questions.first(:conditions => "description is not null")

    segments.each_with_index do |segment, i|
      question = questions_party.questions.first(:include => [:survey], :conditions => ["surveys.segment_id = ?", segment.id])
      row = [segment.name]
      row << (question.nil? ? "-" : question.number)

      if question.present?
        answers = Answer.all(:conditions => ["question_id in (?) and surveys.segment_id = ?", question.id, segment.id], :include => :survey)
        row << answers.map(&:mean).avg
      else
        row << "-"
      end
#      row << Institution.mean_questions_parties_by_sl(indicator, @service_level)[:mean] # Media da questao

      if i == 2
        answers = Answer.all(:conditions => ["question_id in (?)", questions_party.questions.map(&:id)])
        mean = answers.map(&:mean)
        row << mean.avg
        if @group.present?
          row << Institution.mean_indicator_by_group(indicator, @service_level, @group)[:mean] #Media do Grupo
        else
          row << "-"
        end
        row << Institution.mean_indicator_by_sl(indicator, @service_level)[:mean].inspect # media da rede
      else
        3.times { row << "-" }
      end

      data << row
    end
    data

    OpenStruct.new(
      :question_numbers => data.map{ |i| i[1] }, # numero da questao
      :mean_by_segment => data.map{ |i| "%0.2f" % i[2] rescue "-" }, # media por segmento
      :question_mean => ("%0.2f" % data[2][3] rescue "-"),          # media da questao
      :group_mean => ("%0.2f" % data[2][4] rescue "-"),          # media do grupo
      :sl_mean => ("%0.2f" % data[2][5] rescue "-"),          # media da rede
      :question => display_question
    )
    # puts Ruport::Data::Table.new(:column_names => header, :data => data).to_text
  end

  def dimension_graph(dnumber)
    graph_start_time = now = Time.now
    d = Dimension.find_by_number(dnumber)

    data_sl = Institution.mean_dimension_by_sl(d, @service_level)
    sl_time = Time.now - now
    now = Time.now
    # p data_sl

    p "Graph Dimension: #{d.number}. #{d.name}"

    g = @institution.users.first(:conditions => {:service_level_id => @service_level.id}, :include => :group).group
    data_group = Institution.mean_dimension_by_group(d, @service_level, g)
    group_time = Time.now - now
    now = Time.now

    # p data_group

    data = @institution.mean_dimension(d,@service_level)
    dimension_time = Time.now - now
    now = Time.now

    graph = @institution.graph(data, data_group, data_sl, @service_level, :id => d.number )
    p_times(graph, :sl => sl_time, :group => group_time, :dimension => dimension_time, :graph => Time.now - now, :total => Time.now - graph_start_time)
    graph
  end

  def indicators_graph(dnumber)
    d = Dimension.find_by_number(dnumber)
    indicators = d.indicators.all(:conditions => {:service_level_id => @service_level.id})

    filenames = indicators.inject([]) do |list, i|
      list << indicator_graph(i)
    end
    return filenames
  end

  def indicator_graph(indicator)
    i = indicator.is_a?(Numeric) ? Indicator.find(indicator) : indicator
    now = graph_start_time = Time.now
    data_sl = Institution.mean_indicator_by_sl(i, @service_level)
    sl_time = Time.now - now
    now = Time.now

    data_group = Institution.mean_indicator_by_group(i,@service_level, @group)
    group_time = Time.now - now
    now = Time.now

    data = @institution.mean_indicator(i,@service_level)

    unless i.name.blank?
      graph = @institution.graph(data, data_group, data_sl, @service_level, :id => "i#{i.id}", :title => "#{i.number} - #{i.name}")
      now2 = Time.now
      p_times(graph, :sl => sl_time, :group => group_time, :graph => now2 - now, :total => now2 - graph_start_time)
      return graph
    end
  end

  def p_times(filename, times={})
    t = []
    times.to_a.reverse.each do |k, v|
      t << ("%s: %0.3f" % [k, v])
    end
    p "Generated #{File.basename(filename)} (#{t.join(", ")})"
  end

  def index_table
    means_sl = {}
    means_group = {}
    means = {}
    (1..11).each do |dim|
      d = Dimension.find_by_number(dim)

      data_sl = Institution.mean_dimension_by_sl(d,@service_level)
      means_sl[d.id] = data_sl

      p data_sl

      p "============================================================================================"

      g = (@institution.users.select { |u| u.service_level == @service_level }).first.group
      data_group = Institution.mean_dimension_by_group(d,@service_level,g)
      means_group[d.id] = data_group

      p data_group

      data = @institution.mean_dimension(d,@service_level)
      means[d.id] = data_group
    end
    @institution.grade_to_table(means_sl,means_group,means,@service_level)
  end

end

