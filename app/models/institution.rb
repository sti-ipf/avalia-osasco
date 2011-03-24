# encoding: UTF-8

class Array
  def sum_values
    map(&:to_f).reject(&:nan?).inject(:+)
  end

  def avg
    sum = sum_values
    sum ||= 0
    return 0 if length.to_f == 0
    sum / length.to_f
  end
end

class Hash
  def avg
    values.avg
  end

  def sum_values
    values.sum_values
  end
end

class Institution < ActiveRecord::Base
  has_and_belongs_to_many :service_levels
  has_many :users
  has_many :groups, :through => :users, :uniq => true

  named_scope :by_group, proc { |group| {:conditions => ["groups.id = ?", group.id], :include => {:users => :group}} }
  named_scope :by_service_level, proc { |service_level| {:conditions => ["service_levels.id = ?", service_level.id], :include => :service_levels} }

  def <=>(other)
    name <=> other.name
  end

  def self.mean_dimension_by_sl(dimension,service_level)
    indicators = dimension.indicators.by_service_level(service_level)
    dimension_mean = { :mean => 0 }
    indicators_means = []
    @users_data = Hash.new { |h, k| h[k] = Hash.new }
    indicators.each do |indicator|
      questions_parties = indicator.questions_parties
      indicator_means = []
      questions_means = []
      questions_parties.each do |qp|
        qp.questions.each do |q|
          @curr_answers = {}
          answers = q.answers.valid.by_service_level(service_level).min_participants(0).newer
          answers.each do |a|
            @curr_answers[a.user_id] ||= a.mean
            @users_data[a.user_id][a.question_id] ||= a
          end
            questions_means << @curr_answers.avg
        end
      end
        indicators_means << questions_means.avg
    end
    #if indicators_means.size > 0
      dimension_mean[:mean] = indicators_means.avg
    #end
    dimension_mean[:segments] = Institution.mean_by_segments(@users_data)
    dimension_mean[:mean] = dimension_mean[:segments].avg
    dimension_mean
  end

  def self.mean_indicator_by_sl(indicators_party,service_level)
    indicators = indicators_party.indicators
    indicator_mean = { :mean => 0 }
    indicators_party_means = []
    @users_data = Hash.new { |h, k| h[k] = Hash.new }
    indicators.each do |indicator|
      questions_parties = indicator.questions_parties
      indicator_means = []
      questions_means = []
      questions_parties.each do |qp|
        qp.questions.each do |q|
          @curr_answers = {}
          answers       = q.answers.valid.by_service_level(service_level).min_participants(0).newer
          answers.each do |a|
            @curr_answers[a.user_id] ||= a.mean
            @users_data[a.user_id][a.question_id] ||= a
          end
          #if @curr_answers.keys.size > 0
            questions_means << @curr_answers.avg
          #end
        end
      end
      #if questions_means.size > 0
        indicators_party_means << questions_means.avg
      #end
    end
    #if indicators_party_means.size > 0
      indicator_mean[:mean] = indicators_party_means.avg
    #end
    indicator_mean[:segments] = Institution.mean_by_segments(@users_data)
    indicator_mean[:mean] = indicator_mean[:segments].avg
    indicator_mean
  end

  def self.mean_questions_parties_by_sl(indicator,service_level)
    questions_parties_mean = { :sl => {} }
    questions_parties = indicator.questions_parties
    parties = {}
    questions_parties.each do |qp|
      questions_mean = []
      @curr_answers = {}
      qp.questions.each do |q|
        answers = q.answers.valid.by_service_level(service_level).min_participants(0).newer
        answers.each do |a|
          @curr_answers[a.user_id] ||= a.mean
        end
        #if @curr_answers.keys.size > 0
          questions_mean << @curr_answers.avg
        #end
      end
      #if questions_mean.size > 0
        questions_parties_mean[:sl][qp.id] = questions_mean.avg
      #end
    end
    questions_parties_mean
  end

  def self.mean_indicator_by_group(indicators_party,service_level,group)
    indicators = indicators_party.indicators
    indicator_mean = { :mean => 0 }
    indicators_party_means = []
    @users_data = Hash.new { |h, k| h[k] = Hash.new }
    indicators.each do |indicator|
      questions_parties = indicator.questions_parties
      indicator_means = []
      questions_means = []
      questions_parties.each do |qp|
        qp.questions.each do |q|
          @curr_answers = {}
          answers = q.answers
          answers = q.answers.by_group(group).valid.min_participants(0).newer
          answers.each do |a|
            @curr_answers[a.user_id] ||= a.mean
            @users_data[a.user_id][a.question_id] ||= a
          end
          #if @curr_answers.keys.size > 0
            questions_means << @curr_answers.avg
          #end
        end
      end
      #if questions_means.size > 0
        indicators_party_means << questions_means.avg
      #end
    end
    #if indicators_party_means.size > 0
      indicator_mean[:mean] = indicators_party_means.avg
    #end
    indicator_mean[:segments] = Institution.mean_by_segments(@users_data)
    indicator_mean[:mean] = indicator_mean[:segments].avg
    indicator_mean
  end


  def self.mean_questions_parties_by_group(indicator, service_level, group)
    questions_parties_mean = { :group => {} }
    questions_parties = indicator.questions_parties
    parties = {}
    questions_parties.each do |qp|
      questions_mean = []
      @curr_answers = {}
      qp.questions.each do |q|
        answers = q.answers.by_group(group).valid.min_participants(0).newer
        answers.each do |a|
          @curr_answersa[a.user_id] = a.mean
        end
        #if @curr_answers.keys.size > 0
          questions_mean << @curr_answers.avg
        #end
      end
      #if questions_mean.size > 0
        questions_parties_mean[:group][qp.id] = questions_mean.avg
      #end
    end
    questions_parties_mean
  end


  def self.mean_dimension_by_group(dimension,service_level,group)
    indicators = dimension.indicators.all(:conditions => {:service_level_id => service_level})
    dimension_mean = { :mean => 0 }
    indicators_means = []
    @users_data = Hash.new { |h, k| h[k] = Hash.new }
    indicators.each do |indicator|
      questions_parties = indicator.questions_parties
      indicator_means = []
      questions_means = []
      questions_parties.each do |qp|
        qp.questions.each do |q|
          @curr_answers = {}
          answers = q.answers.by_group(group).valid.min_participants(0).newer
          answers.each do |a|
            @curr_answers[a.user_id] ||= a.mean
            @users_data[a.user_id][a.question_id] ||= a
          end
          #if @curr_answers.keys.size > 0
            questions_means << @curr_answers.avg
          #end
        end
      end
      #if questions_means.size > 0
        indicators_means << questions_means.avg
      #end
    end
    #if indicators_means.size > 0
      dimension_mean[:mean] = indicators_means.avg
    #end
    dimension_mean[:segments] = Institution.mean_by_segments(@users_data)
    dimension_mean[:mean] = dimension_mean[:segments].avg
    dimension_mean
  end

  def mean_questions_indicator(indicator,service_level)
    questions_parties = indicator.questions_parties
    means = {}
    questions_parties.each do |qp|
      qp.questions.each do |q|
        means[q] = mean_questions(qp.id)
      end
    end
    means
  end

  def mean_questions(party_id)
    questions = QuestionsParty.find(party_id)
    mean = {}
    questions.each do |q|
      answers = q.answers
      answers = anwsers.by_service_level(service_level).valid.min_participants(0).newer
      curr_answer = {}
      answers.each do |a|
        @curr_answers[a.user_id] ||= a.mean
      end
      #if @curr_answers.keys.size > 0
        answer = @curr_answers.avg.round(2)
        mean[q.survey.segment.name] =  [q.number,answer]
      #end
    end
    mean
  end

  def mean_dimension(dimension,service_level)
    indicators = dimension.indicators.select { |i| i.service_level == service_level }
    indicators_parties = []
    indicators_values = []
    segments_names = []
    data = Hash.new { |h, k| h[k] = Hash.new{ |h, k| h[k] = Hash.new } }
    indicators.each do |indicator|
      indicators_party_id = indicator.indicators_party_id
      if !indicators_parties.include?(indicators_party_id) && !indicators_party_id.nil?
        indicators_parties << indicator.indicators_party_id
      end
    end
    indicators_parties.each do |ip|
      indicators_values << mean_indicator(IndicatorsParty.find(ip),service_level)
    end
    mean_values = []
    hash_temp = Hash.new { |h, k| h[k] = []}
    indicators_values.each do |v|
      v[:segments].keys.each do |key|
        segments_names << key if !segments_names.include?(key)
      end
    end
    indicators_values.each do |i|
      mean_values << i[:mean]
      segments_names.each do |seg_name|
        hash_temp[seg_name] << i[:segments][seg_name]
      end
    end
    data[:mean] = mean_values.avg
    %w(Familiares Funcionarios Gestores).each{|seg_name| data[:segments][seg_name] = 0}
    segments_names.each do |seg_name|
      data[:segments][seg_name] = hash_temp[seg_name].avg
    end
    data
  end
#{:mean=>4.02, :segments=>{"Familiares"=>3.81, "Funcionarios"=>3.83, "Gestores"=>4.42}}
  def mean_indicator(indicators_party,service_level)
    indicators = indicators_party.indicators
    indicators_numbers = []
    questions_numbers = []
    segments_names = []
    data = Hash.new { |h, k| h[k] = Hash.new{ |h, k| h[k] = Hash.new } }
    indicators.each do |indicator|
      indicators_numbers << indicator.number if !indicators_numbers.include?(indicator.number)
      questions_parties = indicator.questions_parties
      questions_parties.each do |qp|
        qp.questions.each do |q|
          questions_numbers << q.number if !questions_numbers.include?(q.number)
          segment_name = nil
          answers = q.answers.with_institution(self).by_service_level(service_level).min_participants(0).newer
          unless answers.nil?
            answers.each do |a|
              segment_name = User.find(a.user_id, :include => :segment).segment.name
              data[indicator.number][q.number][segment_name] = (a.mean.nil?) ? 0.0 : a.mean
            end
            if answers.size == 0 && q.present?
              result = Question.find_by_sql(
              "SELECT seg.name as segment_name FROM questions_parties qp
                INNER JOIN questions q ON q.questions_party_id = qp.id
                INNER JOIN surveys s ON s.id = q.survey_id
                INNER JOIN segments seg ON seg.id = s.segment_id
                WHERE qp.id = #{qp.id}")
              result.each do |r|
                data[indicator.number][q.number][r.segment_name] = 0 if !r.segment_name.nil?
              end
            end
          end
          segments_names << segment_name if !segments_names.include?(segment_name) && !segment_name.nil?
        end
      end
    end
    calc_mean_indicator(data, indicators_numbers, questions_numbers, segments_names)
  end

  def calc_mean_indicator(data, indicators, questions_numbers, segments_names)
    hash = Hash.new
    hash[:segments] = Hash.new
    puts questions_numbers.inspect
    segments_names.each do |sn|
      array_temp = []
      indicators.each do |i|
        next if sn.nil?
        questions_numbers.each do |qn|
          value = data[i][qn][sn]
          array_temp << value if value.to_s != "0.0" && !value.nil?
        end
      end
      total = array_temp.sum_values
      hash[:segments][sn] = total / array_temp.size.to_f if !total.nil?
    end
    media = hash[:segments].values.sum_values
    if !media.nil?
      hash[:mean] = media / hash[:segments].size.to_f
    else
      hash[:mean] = 0
    end
    hash
  end

  def graph(mean, mean_group, mean_sl, service_level, options = {})
    indicators = options[:indicators]
    segments = service_level.segments.sort

    # Graph labels
    graph_labels =  {}

    # Graph data
    graph_data = segments.inject(Hash.new { |h, k| h[k] = [] }) do |hash, seg|
      hash["Media da UE"] << mean[:segments][seg.name].to_f
      hash["Media do Grupo"] << mean_group[:segments][seg.name].to_f
      hash["Media das #{service_level.name}s"] << mean_sl[:segments][seg.name].to_f

      graph_labels[graph_labels.length] = indicators.present? ? "#{seg.name}\n(#{indicators[seg.name]})" : seg.name
      hash
    end

    graph_data["Media da UE"] << mean[:mean]
    graph_data["Media do Grupo"] << mean_group[:mean]
    graph_data["Media das #{service_level.name}s"] << mean_sl[:mean]

    graph_labels[graph_labels.length] = "Geral"

    # table = Table(graph_labels.values, :data => graph_data.values)
    # puts table.to_text

    graph = UniFreire::Graphs::Base.new("450x300",
    :labels => graph_labels,
    :title => options[:title]
    )
    graph_data.each do |name, data|
      graph.data(name, data)
    end
    graph.data(" ", Array.new(segments.length, 0))
    graph.save_temporary("#{Rails.root}/tmp/graphs/#{id}/#{service_level.id}", "#{options[:id]}-")
  end

  def grade_to_table_burjato(mean,sl)
    table = []
    header = ["Dimensão","Familiares","Funcionarios","Gestores","Índice da UE"]
    header = header.reject { |i| i == "Educandos" } if sl.id != 2
    table << header

    col0  = ["1. Ambiente Educativo","2. Ambiente Físico Escolar e Materiais","3. Avaliação","4. Planejamento Institucional e Prática Pedagógica","5. Acesso e Permanência dos Educandos na Escola","6. Promoção da Saúde","7. Educação Socioambiental e Práticas Ecopedagógicas","8. Envolvimento com as Famílias e Participação na Rede de Proteção Social","9. Gestão Escolar Democrática","10. Formação e Condições de Trabalho dos Profissionais da Escola","11. Processos de Alfabetização e Letramento (Somente para as EMEFs)"]
# Fabrício - comentado para considerar a dimensão 11
#    col0 = col0.reject { |i| i == "11. Processos de Alfabetização e Letramento (Somente para as EMEFs)" } if sl.id != 2

    sum   = 0
    names = sl.segments.collect { |seg| seg.name }.sort!

    col0.each_index do |index|
      p index
      dimension               = Dimension.find_by_number(index + 1)

      segments_dimension      = mean[dimension.id][:segments]
      grade_segments          = names.inject([]) {|array, name| array << (segments_dimension[name].to_f/5).round(2); array}

      average_dimension       = (((segments_dimension.sum_values.to_f)/names.length)/5).round(2)

      value_row               = [average_dimension]

      sum                     = sum + (((segments_dimension.sum_values.to_f)/names.length)/5)

      table << [col0[index]].concat(grade_segments).concat(value_row)
    end

    {:table => table, :institution_main_index => (sum.to_f/col0.size).round(2) }
  end

  def self.mean_by_segments(users_data)
    mean = {}
    data = {}
    users_data.each do |u_id,answers|
      u_mean = answers.values.map(&:mean).avg.round(2)
      u = User.find(u_id, :include => :segment)
      data[u.segment.name] ||= []
      data[u.segment.name] << u_mean
    end
    data.each do |seg,values|
      mean[seg] = values.avg
    end
    mean
  end

  def mean_by_segments(user_data)
    mean = {}
    data = {}
    u_mean = user_data[:answers].values.map(&:mean).avg.round(2)
    u = User.find(user_data[:u_id], :include => :segment)
    data[u.segment.name] ||= []
    data[u.segment.name] << u_mean
    data.each do |seg,values|
      mean[seg] = values.avg
    end
    mean
  end

  def service_level_graph(sl_average_by_dimension, service_level, options = {})
    segments = %w(Educandos Familiares Funcionarios Gestores Professores)

    # Graph labels
    graph_labels =  {}
    segments.each {|k,v| graph_labels[graph_labels.length] = k}

    a={}
    sl_average_by_dimension.each do |i|
      avgs = i[1][:segments]
      graph_avgs = [avgs["Educandos"] ? avgs["Educandos"] : 0.0, avgs["Familiares"], avgs["Funcionarios"], avgs["Gestores"], avgs["Professores"]]
      a[i[0]] = graph_avgs
    end

    graph = UniFreire::Graphs::Base.new("450x300",
      :labels => graph_labels,
      :title => options[:title]
    )

    a.each {|name, data| graph.data(name, data)}

    graph.data(" ", Array.new(segments.length, 0))
    graph_path = "#{Rails.root}/tmp/graphs/#{id}"
    graph.save_temporary(graph_path, "general_average_dimension#{options[:id]}-")
  end

  def single_institution_graph(mean, service_level, options = {})
    indicators = options[:indicators]
    segments = service_level.segments.sort

    # Graph labels
    graph_labels =  {}

    # Graph data
    graph_data = segments.inject(Hash.new { |h, k| h[k] = [] }) do |hash, seg|
      media = if mean[:segments][seg.name].class == Hash || mean[:segments][seg.name].nil?
                0
              else
                mean[:segments][seg.name]
              end
      hash["Media da UE"] << media
      # hash["Media do Grupo"] << mean_group[:segments][seg.name].to_f
      # hash["Media das #{service_level.name}s"] << mean_sl[:segments][seg.name].to_f
      graph_labels[graph_labels.length] = indicators.present? ? "#{seg.name}\n(#{indicators[seg.name]})" : seg.name
      hash
    end

    graph_data["Media da UE"] << mean[:mean]
    # graph_data["Media do Grupo"] << mean_group[:mean]
    # graph_data["Media das #{service_level.name}s"] << mean_sl[:mean]

    graph_labels[graph_labels.length] = "Geral"

    graph = UniFreire::Graphs::Base.new("450x300",
                                        { :labels => graph_labels,
                                          :title => options[:title],
                                          :theme => {
                                            :colors => ['white','#3704ba','white'],
                                            :marker_color => 'black',
                                            :background_colors => 'white'
                                          }
                                        }
    )

    graph_data.each do |name, data|
      graph.data(" ", Array.new(segments.length, 0))
      graph.data(name, data)
      graph.data(" ", Array.new(segments.length, 0))
    end

    graph.save_temporary("#{Rails.root}/tmp/graphs/#{id}/#{service_level.id}", "#{options[:id]}-")
  end
end

