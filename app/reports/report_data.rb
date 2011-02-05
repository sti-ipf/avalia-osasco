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
  
  

  def questions_party_table(questions_party)
    data = []

    segments =  %W(Professores Gestores Educandos Funcionários Familiares).map { |sname| Segment.first(:conditions => {:name => sname}) }.compact
   
    psegment = segments.select { |s| s.name == "Professores" }.first
    questions_party = QuestionsParty.find(questions_party, :include => {:questions => :indicator})
    display_question = questions_party.questions.first(:include => [:survey], :conditions => ["surveys.segment_id = ?", psegment.id])
    display_question ||= questions_party.questions.first(:conditions => "description is not null")

    segments.each_with_index do |segment, i|
      question = questions_party.questions.first(:include => [:survey], :conditions => ["surveys.segment_id = ?", segment.id])
      row = [segment.name]
      row << (question.nil? ? "-" : question.number)

      if question.present?
        answers = Answer.all(:conditions => ["question_id in (?) and surveys.segment_id = ?", question.id, segment.id], :include => :survey)
        row << answers.map(&:mean).avg.to_f.round(2)
      else
        row << "-"
      end

      if i == 2
        answers = Answer.all(:conditions => ["question_id in (?)", questions_party.questions.map(&:id)])
        mean = answers.map(&:mean)
        row << mean.avg.to_f.round(2)
        if @group.present?
          row << questions_party.mean_by_group(@group).to_f.round(2) #Media do Grupo
        else
          row << "-"
        end
        row << questions_party.mean_by_sl.to_f.round(2) # media da rede
      else
        3.times { row << "" }
      end
      data << row
    end
    {:description => display_question.description, :table => data}
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

  def indicator_graph(indicator_param)
    indicator = indicator_param.is_a?(Numeric) ? Indicator.find(indicator_param) : indicator_param
    now = graph_start_time = Time.now
    data_sl = Institution.mean_indicator_by_sl(indicator, @service_level)
    sl_time = Time.now - now
    now = Time.now

    data_group = Institution.mean_indicator_by_group(indicator,@service_level, @group)
    group_time = Time.now - now
    now = Time.now

    data = @institution.mean_indicator(indicator,@service_level)

    unless indicator.name.blank?
      graph = @institution.graph(data, data_group, data_sl, @service_level, :id => "i#{indicator.indicators_party.id}", :title => "#{indicator.number} - #{indicator.name}")
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

