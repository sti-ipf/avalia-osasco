class EvaluationController < ApplicationController
  def index
    @schools = School.all.collect{ |school| [school.name, school.id] }
  end

  def authenticate
    
    @password = Password.find_by_password_and_school_id(params[:password], params[:school])
    if !@password.nil?    
      @segment = @password.segment
      @school = @password.school
      @service_level = @school.service_level
      generate_steps
      render "confirm"
    else
      @schools = School.all.collect{ |school| [school.name, school.id] }
      render "index", :notice => 'Senha invalida para a escola selecionada.'
    end      
  end

  def identify
    load_params
    generate_steps
    if(params[:commit] == 'sim')
      render "identify"
    else
      @schools = School.all.collect{ |school| [school.name, school.id] }
      render "index", :notice => 'Escola e segmento nao confirmados, por favor digite uma nova senha.'
    end
  end

  def instructions
    load_params
    generate_steps
    render "instructions"
  end

  def answerdimension
    load_params
    @dimension_status = DimensionStatus.find_by_sql(["select d.id, d.number, ds.status
                                                        from dimensions d
                                                          left join dimension_statuses ds on d.id = ds.dimension_id
                                                            and ds.segment_id = ? and ds.school_id = ?
                                                        where
                                                          d.service_level_id =?
                                                          and (ds.status is null or ds.status in(?, ?))
                                                          order by d.number", @segment.id, @school.id, @service_level.id, DimensionStatus::IN_PROGRESS, DimensionStatus::NOT_STARTED])
    if @dimension_status.size == 0
      redirect_to :action => "presence_list", :school => @school.id, :segment => @segment.id, :service_level => @service_level.id
      return
    end
    @dimension = Dimension.find(@dimension_status[0].id)

    @practices = Practice.find_by_segment_id_and_school_id_and_dimension_id(@segment.id, @school.id, @dimension.id)

    update_dimension_status DimensionStatus::IN_PROGRESS
    load_questions
    generate_steps
    render "answer"
  end

  def review
    load_params

    do_not_know = params[:do_not_know]
    do_not_answer = params[:do_not_answer]
    quantity_of_people = params[:quantity_of_people]
    one = params[:one]
    two = params[:two]
    three = params[:three]
    four = params[:four]
    five = params[:five]
    consolidated_practices = params[:consolidated_practices]
    to_be_improved_practices = params[:to_be_improved_practices]
    quantity_of_people.each_pair do |k, v|
      answer = Answer.find_by_question_text_id(k.to_i)
      if answer.nil?
        Answer.create(:school => @school, :segment => @segment, :question_text_id => k.to_i,
                      :do_not_know => do_not_know[k], :do_not_answer => do_not_answer[k],
                      :quantity_of_people => quantity_of_people[k], :one => one[k],
                      :two => two[k], :three => three[k], :four => four[k], :five => five[k])
      else
        answer.do_not_know = do_not_know[k]
        answer.do_not_answer = do_not_answer[k]
        answer.quantity_of_people = quantity_of_people[k]
        answer.one = one[k]
        answer.two = two[k]
        answer.three = three[k]
        answer.four = four[k]
        answer.five = five[k]
        answer.save
      end
    end
    @practice = Practice.find_by_segment_id_and_school_id_and_dimension_id(@segment.id, @school.id, @dimension.id)
    if @practice.nil?
      @practice = Practice.create(:school => @school, :segment => @segment, :dimension => @dimension,
                    :consolidated => consolidated_practices, 
                    :to_be_improved => to_be_improved_practices)
    else
      @practice.consolidated = consolidated_practices
      @practice.to_be_improved = to_be_improved_practices
      @practice.save
    end
    update_dimension_status DimensionStatus::IN_PROGRESS
    load_questions
    generate_steps
    render "review"
  end

  def checkreview
    load_params
    generate_steps
    load_questions
    @practices = Practice.find_by_segment_id_and_school_id_and_dimension_id(@segment.id, @school.id, @dimension.id)
    if(params[:commit] == 'modificar')
      render "answer"
    else
      render "save"
    end
  end

  def save
    load_params
    generate_steps
    update_dimension_status DimensionStatus::FINISHED
    if(params[:commit] == 'ir para proxima dimensao')
      redirect_to :action => "answerdimension", :school => @school.id, :segment => @segment.id, :service_level => @service_level.id
    else
      render "finish"
    end
  end

  def presence_list
    load_params
    generate_steps
    @presence = Presence.find_all_by_segment_id_and_school_id(@segment.id, @school.id)

    render "presence_list"
  end

  def save_presence_list
    load_params
    generate_steps
    presence_list = params[:new_presence]
    presence_list.each_pair do |k, v|
      Presence.create(:name => v, :school => @school, :segment => @segment)
    end
    render "finish"
  end


private 
  def update_dimension_status status
    @dimension_status = DimensionStatus.find_by_segment_id_and_school_id_and_dimension_id(@segment.id, @school.id, @dimension.id)
    if @dimension_status.nil?
      @dimension_status = DimensionStatus.create(:school => @school, :segment => @segment, :dimension => @dimension,
                                                 :status => status)
    else
      @dimension_status.status = status
      @dimension_status.save
    end
  end
  def generate_steps
    @steps = []
    @steps << ["Autenticacao", "Autenticacao"]
    @steps << ["Confirmacao segmento", "Confirmacao segmento"]
    @steps << ["Identificacao","Identificacao"]
    @steps << ["Instrucoes basicas", "Instrucoes basicas"]
    @service_level.dimensions.each do |sl|
      @steps << [sl.name, "Dimensao #{sl.number}"]
    end
    @steps << ["Lista de presenca", "Lista de presenca"]
  end

  def load_questions
    @questions = QuestionText.find_by_sql(["select qt.*
                                          from question_texts qt
                                            inner join questions q on qt.question_id = q.id
                                            inner join indicators i on q.indicator_id = i.id
                                            inner join dimensions d on i.dimension_id = d.id
                                          where
                                            q.service_level_id = ?
                                            and qt.segment_id = ?
                                            and d.id = ?", @service_level.id, @segment.id, @dimension.id])

  end
  def load_params
    @school = School.find(params[:school])
    @service_level = ServiceLevel.find(params[:service_level])
    @segment = Segment.find(params[:segment])
    @name = params[:name]
    @dimension = Dimension.find_by_number_and_service_level_id(params[:dimension], @service_level.id)
  end
end
