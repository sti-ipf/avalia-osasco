# require "ruport"

class Array
  def sum_values # TODO: rever
    map(&:to_f).reject(&:nan?).inject(:+)
  end

  def avg
    sum_values / length.to_f
  end
end

class Hash
  def avg
    values.avg
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
      questions = indicator.questions
      indicator_means = []
      questions_means = []
      questions.each do |q|
        @curr_answers = {}
        answers = q.answers.min_participants(0).newer
        answers.each do |a|
          @curr_answers[a.user_id] ||= a.mean
          @users_data[a.user_id][a.question_id] ||= a

        end
        if @curr_answers.keys.size > 0
          questions_means << @curr_answers.avg
        end
      end
        if questions_means.size > 0
          indicators_means << questions_means.avg
        end
    end
    if indicators_means.size > 0
      dimension_mean[:mean] = indicators_means.avg
    end
    dimension_mean[:segments] = Institution.mean_by_segments(@users_data)
    dimension_mean
  end

  def self.mean_indicator_by_sl(indicator,service_level)
    indicators = (indicator.colleagues << indicator)
    indicator_mean = { :mean => 0 }
    indicators_party_means = []
    @users_data = Hash.new { |h, k| h[k] = Hash.new }
    indicators.each do |indicator|
      questions = indicator.questions
      indicator_means = []
      questions_means = []
      questions.each do |q|
        @curr_answers = {}
        answers = q.answers.min_participants(0).newer
        # answers.reject! { |a| a.participants_number == 0 }
        # answers.reverse! { |u,v| u.created_at <=> v.created_at }
        answers.each do |a|
          @curr_answers[a.user_id] ||= a.mean
          @users_data[a.user_id][a.question_id] ||= a
        end
        if @curr_answers.keys.size > 0
          questions_means << @curr_answers.avg
        end
      end
        if questions_means.size > 0
          indicators_party_means << questions_means.avg
        end
    end
    if indicators_party_means.size > 0
      # indicator_mean[:mean] = (indicators_party_means.inject(nil) { |sum,v| sum ? sum + v :  v }.to_f/indicators_party_means.size).round(2)
      indicator_mean[:mean] = indicators_party_means.avg
    end
    indicator_mean[:segments] = Institution.mean_by_segments(@users_data)
    indicator_mean
  end

  def self.mean_questions_parties_by_sl(indicator,service_level)
    questions_parties_mean = { :sl => {} }
    questions = indicator.questions
    parties = {}
    questions.each do |q|
      parties[q.questions_party_id] = q.colleagues <<  q
    end
    parties.each do |k,p|
      questions_mean = []
      @curr_answers = {}
      p.each do |q|
        answers = q.answers.min_participants(0).newer
        # answers.reject! { |a| a.participants_number == 0 }
        # answers.reverse! { |u,v| u.created_at <=> v.created_at }
        answers.each do |a|
          @curr_answers[a.user_id] ||= a.mean
        end
        if @curr_answers.keys.size > 0
          questions_mean << @curr_answers.avg
        end
      end
      if questions_mean.size > 0
        questions_parties_mean[:sl][k] = questions_mean.avg
      end
    end
    questions_parties_mean
  end

  def self.mean_indicator_by_group(indicator,service_level,group)
    indicators = (indicator.colleagues << indicator)
    indicator_mean = { :mean => 0 }
    indicators_party_means = []
    @users_data = Hash.new { |h, k| h[k] = Hash.new }
    indicators.each do |indicator|
      questions = indicator.questions
      indicator_means = []
      questions_means = []
      questions.each do |q|
        @curr_answers = {}
        answers = q.answers
        # users_ids = group.user_ids
        answers = q.answers.by_group(group).min_participants(0).newer # .select { |a| users_ids.include?(a.user_id) &&  a.participants_number > 0 }
        # answers.reverse! { |u,v| u.created_at <=> v.created_at }
        answers.each do |a|
          @curr_answers[a.user_id] ||= a.mean
          @users_data[a.user_id][a.question_id] ||= a
          # if  @users_data.keys.include?(a.user_id)
          #   if @users_data[a.user_id][a.question_id] && (@users_data[a.user_id][a.question_id].created_at < a.created_at)
          #     @users_data[a.user_id][a.question_id] = a
          #   else
          #     @users_data[a.user_id][a.question_id] = a
          #   end
          # else
          #   @users_data[a.user_id] = {a.question_id => a}
          # end
        end
        if @curr_answers.keys.size > 0
          questions_means << @curr_answers.avg
        end
      end
        if questions_means.size > 0
          indicators_party_means << questions_means.avg
        end
    end
    if indicators_party_means.size > 0
      indicator_mean[:mean] = indicators_party_means.avg
    end
    indicator_mean[:segments] = Institution.mean_by_segments(@users_data)
    indicator_mean
  end


  def self.mean_questions_parties_by_group(indicator, service_level, group)
    questions_parties_mean = { :group => {} }
    questions = indicator.questions
    parties = {}
    questions.each do |q|
      parties[q.questions_party_id] = q.colleagues <<  q
    end
    parties.each do |k,p|
      questions_mean = []
      @curr_answers = {}
      p.each do |q|
        answers = q.answers.by_group(group).min_participants(0).newer
        # users_ids = group.user_ids
        # answers = answers.select { |a| users_ids.include?(a.user_id) &&  a.participants_number > 0 }
        # answers.reverse! { |u,v| u.created_at <=> v.created_at }
        answers.each do |a|
          @curr_answersa[a.user_id] = a.mean
        end
        p @curr_answers
        if @curr_answers.keys.size > 0
          questions_mean << @curr_answers.avg
        end
      end
      if questions_mean.size > 0
        questions_parties_mean[:group][k] = questions_mean.avg
      end
    end
    questions_parties_mean
  end


  def self.mean_dimension_by_group(dimension,service_level,group)
    indicators = dimension.indicators.all(:conditions => {:service_level_id => service_level})
    dimension_mean = { :mean => 0 }
    indicators_means = []
    @users_data = Hash.new { |h, k| h[k] = Hash.new }
    indicators.each do |indicator|
      questions = indicator.questions
      indicator_means = []
      questions_means = []
      questions.each do |q|
        @curr_answers = {}
        answers = q.answers.by_group(group).min_participants(0).newer
        # users_ids = group.user_ids
        # answers = q.answers.all(:conditions => ["user_id in (?) and participants_number > ?", group.user_ids, 0], :order => "created_at DESC")
        # answers.reverse! { |u,v| u.created_at <=> v.created_at }
        answers.each do |a|
          @curr_answers[a.user_id] ||= a.mean
          @users_data[a.user_id][a.question_id] ||= a
          # @curr_answers.merge!( { a.user_id => a.mean } ) unless @curr_answers.keys.include?(a.user_id)
          # if  @users_data.has_key?(a.user_id)
          #   if @users_data[a.user_id][a.question_id] && (@users_data[a.user_id][a.question_id].created_at < a.created_at)
          #     @users_data[a.user_id][a.question_id] = a
          #   else
          #     @users_data[a.user_id][a.question_id] = a
          #   end
          # else
          #   @users_data[a.user_id] = {a.question_id => a}
          # end
        end
        if @curr_answers.keys.size > 0
          questions_means << @curr_answers.avg
        end
      end
        if questions_means.size > 0
          indicators_means << questions_means.avg
        end
    end
    if indicators_means.size > 0
      dimension_mean[:mean] = indicators_means.avg
    end
    dimension_mean[:segments] = Institution.mean_by_segments(@users_data)
    dimension_mean
  end

  def mean_questions_indicator(indicator,service_level)
    questions
    questions = indicator.questions
    parties = {}
    means = {}
    questions.each do |q|
      parties[q.questions_party_id] = q.colleagues <<  q
    end
    parties.each { |k,p| means[k] = mean_questions(k) }

    means
  end

  def mean_questions(party_id)
    questions = QuestionsParty.find(party_id)
    mean = {}
    questions.each do |q|
      answers = q.answers
      # my_users = users.by_service_level(service_level)
      answers = anwsers.by_service_level(service_level).min_participants(0).newer
      # answers = answers.select { |a| myusers.include?(a.user) &&  a.participants_number > 0 }
      # answers.reverse! { |u,v| u.created_at <=> v.created_at }
      curr_answer = {}
      answers.each do |a|
          @curr_answers[a.user_id] ||= a.mean
      end
      if @curr_answers.keys.size > 0
        answer = @curr_answers.avg.round(2)

        mean[q.survey.segment.name] =  [q.number,answer]
      end
    end
    mean
  end

  def mean_dimension(dimension,service_level)
    indicators = dimension.indicators.select { |i| i.service_level == service_level }
    dimension_mean = { :mean => 0 }
    indicators_means = []
    @users_data = Hash.new { |h, k| h[k] = Hash.new }
    indicators.each do |indicator|
      questions = indicator.questions
      indicator_means = []
      questions_means = []
      questions.each do |q|
        @curr_answers = {}
        # my_users = users.select { |u| u.service_level == service_level }
        answers = q.answers.by_service_level(service_level).min_participants(0).newer
        # unless answers.nil?
          # answers = answers.select { |a| my_users.include?(a.user) &&  a.participants_number > 0 }
          # answers.reverse! { |u,v| u.created_at <=> v.created_at }
          answers.each do |a|
            @curr_answers[a.user_id] ||= a.mean
            @users_data[a.user_id][a.question_id] ||= a
            # if  @users_data.keys.include?(a.user_id)
            #   if @users_data[a.user_id][a.question_id] && (@users_data[a.user_id][a.question_id].created_at < a.created_at)
            #     @users_data[a.user_id][a.question_id] = a
            #   else
            #     @users_data[a.user_id][a.question_id] = a
            #   end
            # else
            #   @users_data[a.user_id] = {a.question_id => a}
            # end
          end
          if @curr_answers.keys.size > 0
            questions_means << @curr_answers.avg
          end
        # end
        if questions_means.size > 0
          indicators_means << questions_means.avg
        end
      end
      if indicators_means.size > 0
        dimension_mean[:mean] = indicators_means.avg
      end
    end
    dimension_mean[:segments] = Institution.mean_by_segments(@users_data)
    dimension_mean
  end


  def mean_indicator(indicator,service_level)
    indicators = (indicator.colleagues << indicator)
    indicator_mean = { :mean => 0 }
    indicators_party_means = []
    @users_data = Hash.new { |h, k| h[k] = Hash.new }
    indicators.each do |indicator|
      questions = indicator.questions
      indicator_means = []
      questions_means = []
      questions.each do |q|
        @curr_answers = {}
        # my_users = users.select { |u| u.service_level == service_level }
        answers = q.answers.by_service_level(service_level).min_participants(0).newer
        unless answers.nil?
          # answers = answers.select { |a| my_users.include?(a.user) &&  a.participants_number > 0 }
          # answers.reverse! { |u,v| u.created_at <=> v.created_at }
          answers.each do |a|
            @curr_answers[a.user_id] ||= a.mean
            @users_data[a.user_id][a.question_id] ||= a
            # @curr_answers.merge!( { a.user_id => a.mean } ) unless @curr_answers.keys.include?(a.user_id)
            # if  @users_data.keys.include?(a.user_id)
            #   if @users_data[a.user_id][a.question_id] && (@users_data[a.user_id][a.question_id].created_at < a.created_at)
            #     @users_data[a.user_id][a.question_id] = a
            #   else
            #     @users_data[a.user_id][a.question_id] = a
            #   end
            # else
            #   @users_data[a.user_id] = {a.question_id => a}
            # end
          end
          if @curr_answers.keys.size > 0
            questions_means << @curr_answers.avg
          end
        end
        if questions_means.size > 0
          indicators_party_means << questions_means.avg
        end
      end
      if indicators_party_means.size > 0
        indicator_mean[:mean] = indicators_party_means.avg
      end
    end
    indicator_mean[:segments] = Institution.mean_by_segments(@users_data)
    indicator_mean
  end


  def graph(mean, mean_group, mean_sl, service_level, options = {})
    indicators = options[:indicators]
    segments = service_level.segments

    # Graph labels
    graph_labels =  {}

    # Graph data
    graph_data = segments.inject(Hash.new { |h, k| h[k] = [] }) do |hash, seg|
      hash["Media da UE"] << mean[:segments][seg.name].to_f
      hash["Media do Grupo"] << mean_group[:segments][seg.name].to_f
      hash["Media das #{service_level.name}s"] << mean_sl[:segments][seg.name].to_f

      graph_labels[graph_labels.length] = indicators.present? ? "#{seg.name}# (#{indicators[seg.name]})" : seg.name
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

    graph_data.sort { |a,b| b[0].gsub(/.*[ ](\w+)$/, '\1') <=> a[0].gsub(/.*[ ](\w+)$/, '\1') }.each do |name, data|
      graph.data(name, data)
    end
    graph.data(" ", Array.new(segments.length, 0))
    graph.save_temporary("#{Rails.root}/tmp/graphs/#{id}", "#{options[:id]}-")
  end

  def grade_to_table(mean_sl,mean_group,mean,sl)
    sum = 0
    table = ["Dimensão","Professores","Gestores","Educandos","Func. de Apoio","Familiares","Índice da UE","Índice do Grupo","Índice da Rede*"]
    col0 = ["1. Ambiente Educativo","2. Ambiente Físico Escolar e Materiais","3. Avaliação","4. Planejamento Institucional e Prática Pedagógica","5. Acesso e Permanência dos Educandos na Escola","6. Promoção da Saúde","7. Educação Socioambiental e Práticas Ecopedagógicas","8. Envolvimento com as Famílias e Participação na Rede de Proteção Social","9. Gestão Escolar Democrática","10. Formação e Condições de Trabalho dos Profissionais da Escola","11. Processos de Alfabetização e Letramento (Somente para as EMEFs)"]

    names = sl.segments.collect { |seg| seg.name }
    names.sort!
    (1..11).each do |d|
      dim = Dimension.find_by_number(d)
      grade_segments = []
      names.each do |name|
        grade_segments << (mean[dim.id][:segments][name].to_f).to_s
      end
      sum = sum + mean[dim.id][:mean].to_f/5
    table << [col0[d]].concat(grade_segments).concat([ (mean[dim.id][:mean].to_f/5).to_s, (mean_group[dim.id][:mean].to_f/5).to_s, (mean_sl[dim.id][:mean].to_f/5).to_s])
    end

    [table,(sum.to_f/11).round(2)]
  end

  def self.mean_by_segments(users_data)
    mean = {}
    data = {}
    users_data.each do |u_id,answers|
      u_mean = answers.values.map(&:mean).avg.round(2)
      u = Rails.cache.fetch("user-#{u_id}") { User.find(u_id, :include => :segment) }
      data[u.segment.name] ||= []
      data[u.segment.name] << u_mean
      # if data[u.segment.name]
      #    data[u.segment.name] << u_mean
      # else
      #   data[u.segment.name] = [u_mean]
      # end
    end
    data.each do |seg,values|
      mean[seg] = values.avg
    end
    mean
  end


#    def graph_indicator(dimension,indicator,service_level,group)
#      data = mean_indicator(dimension,indicator,service_level)
#      mean_group =  Institution.general_mean_indicator(dimension,indicator,group)
#      graph = Gruff::Bar.new("400x300")
#      graph.theme = {
#        :colors => ['orange', 'purple', 'green', 'yellow', 'red', 'blue', '#b56d3c' ],
#        :marker_color => 'black',
#        :background_colors => 'white'
#      }

#      graph.title = "Indicador #{dimension}.#{indicator}"
#      graph.minimum_value = 0
#      graph.maximum_value = 5
#      graph.marker_count = 10
#      graph.sort = false
#      data[:users].each do |user|
#        user.each do |seg,value|
#          graph.data("#{seg} - #{value.to_f.round(2)}",[value.to_f.round(2)])
#        end
#      end
#      graph.data("Media da UE - #{data[:mean].round(2)}",data[:mean].round(2))
#      graph.data("Media do Agrupamento - #{mean_group[:mean].round(2)}",mean_group[:mean].round(2))
#      graph.write("#{RAILS_ROOT}/public/graficos/#{name}_#{service_level.name}_d#{dimension}i#{indicator}.png")
#    end


#    def self.general_graph_dimension(dimension,group)
#      data = self.general_mean_dimension(dimension,group)
#      graph = Gruff::Bar.new("400x300")
#      graph.theme = {
#        :colors => %w(orange purple green yellow red blue brown),
#     :marker_color => 'black',
#        :background_colors => 'white'
#      }

#      graph.title = "#{group.users.first.service_level.name} G#{group.name.split(' ')[1]} D#{dimension}"
#      graph.minimum_value = 0
#      graph.maximum_value = 5
#      graph.marker_count = 10
#      graph.sort = false
#      data.each do |seg,value|
#      graph.data("#{seg} - #{value.round(2)}",[value.round(2)]) unless seg == :mean
#      end
#      graph.data("Media - #{data[:mean].round(2)}",data[:mean].round(2))
#      graph.write("#{RAILS_ROOT}/public/graficos/graficos_geral/#{group.users.first.service_level.name}_#{group.name}_d#{dimension}.png")
#    end

#    def self.general_graph_indicator(dimension,indicator,group)
#      data = self.general_mean_indicator(dimension,indicator,group)
#      graph = Gruff::Bar.new("400x300")
#      graph.theme = {
#        :colors => %w(orange purple green yellow red blue),
#        :marker_color => 'black',
#        :background_colors => 'white'
#      }

#      graph.title = "#{group.users.first.service_level.name} G#{group.name.split(' ')[1]} D#{dimension} I#{indicator}"
#      graph.minimum_value = 0
#      graph.maximum_value = 5
#      graph.marker_count = 10
#      graph.sort = false
#      data.each do |seg,value|
#        graph.data("#{seg} - #{value.to_f.round(2)}",[value.to_f.round(2)]) unless seg == :mean
#      end
#      graph.data("Media - #{data[:mean].round(2)}",data[:mean].round(2))
#      graph.write("#{RAILS_ROOT}/public/graficos/graficos_geral/#{group.users.first.service_level.name}_#{group.name}_d#{dimension}i#{indicator}.png")
#    end

#    def answers_by_dimension(dimension,service_level)
#      surveys = Survey.by_service_level(service_level)
#      @answers = {}
#      surveys.each do |survey|
#        questions = survey.questions_by_dimension(dimension)
#        @answers = questions.collect { |q| { q.number => mean_question(q,service_level) } }
#      end
#      keys_dup = @answers.collect { |e| e.keys.first }
#      keys = keys_dup.uniq

#      @mean = {}

#      keys.each { |k| @mean[k] = {} }
#      keys.each do |k|
#        current_answers =  @answers.select { |e| e.keys.first ==  k }
#        current_answers.each do |e|
#          e.values.first.keys.each { |kl| @mean[k][kl] = 0 }
#          e.values.first.each { |kl,v| @mean[k][kl] = @mean[k][kl] + v }
#        end
#      end
#      @total = {}
#      keys.each do |k|
#        @total[k] =  keys_dup.select { |e| e == k }.size
#      end
#      @mean.each do |k,v|
#        v.each do |seg,value|
#          value = value/@total[k]
#        end
#      end
#      #sorting by question number
#      @mean.to_a.sort_by do |s|
#        a = s[0].split('.')
#        [2,a[3].to_i]
#        [2,a[2].to_i]
#        [2,a[1].to_i]
#      end
#    end

#    def mean_question(question,service_level, type=:users)
#      users_mean = { :mean => 0, :users => {} }
#      users_selected = users.select { |u| u.service_level == service_level }
#      users_selected.each do |user|
#        current_answers = user.answers.select { |a| a.question.number == question.number if a.question }
#        current_answers.reject! { |a| a.participants_number == 0 }
#        user_mean = {}
#        current_answers.each do |a|
#          if user_mean[a.question]
#            if user_mean[a.question][:answer].created_at < a.created_at
#              user_mean[a.question] = { :answer => a, :mean => a.mean }
#            end
#          else
#            user_mean[a.question] = { :answer => a, :mean => a.mean }
#          end
#        end
#        sum = 0
#        user_mean.each { |x| sum = sum + x[1][:mean] }
#        curr_mean = 0
#        curr_mean = sum.to_f/user_mean.size if user_mean.size > 0
#        users_mean[:mean] = users_mean[:mean] + curr_mean
#        users_mean[:users][user.segment.name] = curr_mean
#      end
#      if users_mean[:mean] > 0
#        users_mean[:mean] = users_mean[:mean].to_f/users_selected.size
#      end
#      users_mean[type]
#    end


#    def mean_question_by_group(question,group,type=:users)
#      users_mean = { :mean => 0, :users => {} }
#      users_selected = users.select { |u| u.group == group }
#      users_selected.each do |user|
#        current_answers = user.answers.select { |a| a.question.number == question.number if a.question }
#        current_answers.reject! { |a| a.participants_number == 0 }
#        user_mean = {}
#        current_answers.each do |a|
#          if user_mean[a.question]
#            if user_mean[a.question][:answer].created_at < a.created_at
#              user_mean[a.question] = { :answer => a, :mean => a.mean }
#            end
#          else
#            user_mean[a.question] = { :answer => a, :mean => a.mean }
#          end
#        end
#        sum = 0
#        user_mean.each { |x| sum = sum + x[1][:mean] }
#        curr_mean = 0
#        curr_mean = sum.to_f/user_mean.size if user_mean.size > 0
#        users_mean[:mean] = users_mean[:mean] + curr_mean
#        users_mean[:users][user.segment.name] = curr_mean
#      end
#      if users_mean[:mean] > 0
#        users_mean[:mean] = users_mean[:mean].to_f/users_selected.size
#      end
#      users_mean[type]
#    end

#    def mean_by_group(dimension,service_level)
#      surveys = Survey.by_service_level(service_level)
#      @answers = {}
#      group = users.select { |u| u.service_level == service_level }.first.group
#      surveys.each do |survey|
#        questions = survey.questions_by_dimension(dimension)
#        @answers = questions.collect { |q| { q.number => mean_question_by_group(q,group,:mean) } }
#      end
#      keys_dup = @answers.collect { |e| e.keys.first }
#      keys = keys_dup.uniq

#      @mean = {}

#      keys.each { |k| @mean[k] = 0 }
#      keys.each do |k|
#        current_answers =  @answers.select { |e| e.keys.first ==  k }
#        current_answers.each do |e|
#          e.each { |kl,v| @mean[k] = @mean[k] + v }
#        end
#      end
#      @total = {}
#      keys.each do |k|
#        @total[k] =  keys_dup.select { |e| e == k }.size
#      end
#      @mean.each do |k,v|
#          v = v/@total[k]
#      end
#      @mean.to_a.sort_by do |s|
#        a = s[0].split('.')
#        [2,a[2].to_i]
#        [2,a[1].to_i]
#      end
#    end

#    def mean_by_dimension(dimension,service_level)
#      surveys = Survey.by_service_level(service_level)
#      @answers = {}
#      surveys.each do |survey|
#        questions = survey.questions_by_dimension(dimension)
#        @answers = questions.collect { |q| { q.number => mean_question_by_group(q,service_level,:mean) } }
#      end
#      keys_dup = @answers.collect { |e| e.keys.first }
#      keys = keys_dup.uniq

#      @mean = {}

#      keys.each { |k| @mean[k] = 0 }
#      keys.each do |k|
#        current_answers =  @answers.select { |e| e.keys.first ==  k }
#        current_answers.each do |e|
#          e.each { |kl,v| @mean[k] = @mean[k] + v }
#        end
#      end
#      @total = {}
#      keys.each do |k|
#        @total[k] =  keys_dup.select { |e| e == k }.size
#      end
#      @mean.each do |k,v|
#          v = v/@total[k]
#      end
#      @mean = @mean.to_a
#      @mean = @mean.sort do |u,v|
#        comp = (u[0].split('.')[0] <=> v[0].split('.')[0])
#        if comp.zero?
#          comp1 = (u[0].split('.')[1] <=> v[0].split('.')[1])
#          if comp1.zero?
#            (u[0].split('.')[2] <=> v[0].split('.')[2])
#          else
#            comp1
#          end
#        else
#          comp
#        end
#      end
#    end

#    def dimension_answers_to_table(dimension,service_level)
#      answers = answers_by_dimension(dimension,service_level)
#      group_mean = mean_by_group(dimension,service_level)

#      table =  [["Resposta","Professores","Gestores","Educandos","Func. de Apoio", "Familiares", "Media UE", "Media do Agrupamento" ]]

#      answers.each do |cols|
#        sum = 0
#        cols[1].each { |e| sum = sum + e[1] }
#        curr_mean = sum/cols[1].size
#        curr_group_mean = group_mean.select { |e| e[0] == cols[0] }.first[1]
#        table << [cols[0],cols[1]["Professores"].to_s,cols[1]["Gestores"].to_s,cols[1]["Educandos"].to_s,cols[1]["Funcionarios"].to_s,cols[1]["Familiares"].to_s,curr_mean.to_s,curr_group_mean.to_s]
#      end
#      table
#    end
end

