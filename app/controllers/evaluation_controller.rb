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
      render "index", :notice => 'Senha inválida para a escola selecionada.'
    end      
  end

  def identify
    @school = School.find(params[:school])
    @service_level = ServiceLevel.find(params[:service_level])
    @segment = Segment.find(params[:segment])
    generate_steps
    if(params[:commit] == 'sim')
      render "identify"
    else
      @schools = School.all.collect{ |school| [school.name, school.id] }
      render "index", :notice => 'Escola e segmento não confirmados, por favor digite uma nova senha.'
    end
  end

  def instructions
    @school = School.find(params[:school])
    @service_level = ServiceLevel.find(params[:service_level])
    @segment = Segment.find(params[:segment])
    @name = params[:name]
    generate_steps
    render "instructions"
  end

  def answerdimension
    @school = School.find(params[:school])
    @service_level = ServiceLevel.find(params[:service_level])
    @segment = Segment.find(params[:segment])
    @name = params[:name]
    @dimension = params[:dimension]
    @questions = Question.find_by_sql(["select * 
                                          from questions q 
                                            inner join question_texts qt on q.id = qt.question_id
                                            inner join indicators i on q.indicator_id = i.id
                                            inner join dimensions d on i.dimension_id = d.id
                                          where
                                            q.service_level_id = ?
                                            and qt.segment_id = ?", @service_level.id, @segment.id])
    render "answer"
  end

private 
  def generate_steps
    @steps = []
    @steps << ["Autenticacao", "Autenticacao"]
    @steps << ["Confirmacao segmento", "Confirmacao segmento"]
    @steps << ["Identificacao","Identificacao"]
    @steps << ["Instrucoes basicas", "Instrucoes basicas"]
    @service_level.dimensions.each do |sl|
      @steps << [sl.name, "Dimensao #{sl.number}"]
    end
  end
end
