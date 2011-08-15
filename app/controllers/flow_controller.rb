class FlowController < ApplicationController
  def index
    generate_institutions
  end
  
  def authenticate
    @institution = params[:institution]
    if(params[:password] == '123456' && @institution == "EMEF ALFREDO FARHAT, DEPUTADO")
      @segment = "Familiares"
      @institution_type = "EMEF"
    elsif(params[:password] == '1qa0pk' && @institution == "EMEF ALICE RABECHINI FERREIRA")
      @segment = "Professores e Gestores"
      @institution_type = "EMEF"
    elsif(params[:password] == '2ws9om' && @institution == "EMEF ALIPIO DA SILVA LAVOURA, PROF.")
      @segment = "Funcionarios"
      @institution_type = "EMEF"
    elsif(params[:password] == '3ed8ik' && @institution == "EMEF ANEZIO CABRAL, PROF.")
      @segment = "Educandos"
      @institution_type = "EMEF"
    elsif(params[:password] == '4rf7uj' && @institution == "CRECHE ALHA ELIAS ABIBE")
      @segment = "Familiares"
      @institution_type = "CRECHE"
    elsif(params[:password] == '5tg6yh' && @institution == "CRECHE ALZIRA SILVA MEDEIROS")
      @segment = "Professores e Gestores"
      @institution_type = "CRECHE"
    elsif(params[:password] == 'zxcmnb' && @institution == "CRECHE AMELIA TOZZETO VIVIANE")
      @segment = "Funcionarios"
      @institution_type = "CRECHE"
    end

    if !@segment.nil?
      generate_data
      render "confirm"
    else
      generate_institutions
      render "index"
    end
  end

  def identify
    @institution = params[:institution]
    @institution_type = params[:institution_type]
    @segment = params[:segment]
    generate_data
    if(params[:commit] == 'sim')
      render "identify"
    else
      generate_institutions
      render "index"
    end
  end

  def instructions
    @institution = params[:institution]
    @institution_type = params[:institution_type]
    @segment = params[:segment]
    @name = params[:name]
    generate_data
    render "instructions"
  end

  def answerdimension
    @institution = params[:institution]
    @institution_type = params[:institution_type]
    @segment = params[:segment]
    @name = params[:name]
    @dimension = params[:dimension]
    generate_data
    render "answer"
  end

  def review
    @institution = params[:institution]
    @institution_type = params[:institution_type]
    @segment = params[:segment]
    @name = params[:name]
    @dimension = params[:dimension]
    generate_data
    render "review"
  end

  def checkreview
    @institution = params[:institution]
    @institution_type = params[:institution_type]
    @segment = params[:segment]
    @name = params[:name]
    @dimension = params[:dimension]
    generate_data
    if(params[:commit] == 'modificar')
      render "answer"
    else
      render "save"
    end
  end

private
  def generate_institutions
    @institutions = []
    @institutions << "EMEF ALFREDO FARHAT, DEPUTADO"
    @institutions << "EMEF ALICE RABECHINI FERREIRA"
    @institutions << "EMEF ALIPIO DA SILVA LAVOURA, PROF."
    @institutions << "EMEF ANEZIO CABRAL, PROF."
    @institutions << "EMEF ANTONIO DE SAMPAIO, GENERAL"
    @institutions << "EMEF BENEDICTO WESCHENFELDER"
    @institutions << "EMEF BENEDITO ALVES TURIBIO"
    @institutions << "EMEF BITTENCOURT, MARECHAL"
    @institutions << "EMEF CECILIA CORREA CASTELANI, PROFa"
    @institutions << "EMEF DOMINGOS BLASCO, MAESTRO"
    @institutions << "EMEF ELIDIO MANTOVANI, MONSENHOR"
    @institutions << "EMEF ELZA DE CARVALHO MELLO BATTISTON, PROFa"
    @institutions << "EMEF FRANCISCO CAVALCANTI PONTES DE MIRANDA"
    @institutions << "EMEF FRANCISCO MANUEL LUMBRALES DE SA CARNEIRO, DR."
    @institutions << "EMEF GASPAR DA MADRE DE DEUS, FREI"
    @institutions << "EMEF HUGO RIBEIRO DE ALMEIDA, DR."
    @institutions << "EMEF JOAO CAMPESTRINI, PROF."
    @institutions << "EMEF JOAO EUCLYDES PEREIRA, PROF."
    @institutions << "EMEF JOAO GUIMARAES ROSA"
    @institutions << "EMEF JOAO LARIZZATTI, PROF."
    @institutions << "EMEF JOSE GROSSI DIAS, PADRE"
    @institutions << "EMEF JOSE MANOEL AYRES, DR."
    @institutions << "EMEF JOSE MARTINIANO DE ALENCAR"
    @institutions << "EMEF JOSE VERISSIMO DE MATOS"
    @institutions << "EMEF JOSIAS BAPTISTA, PASTOR"
    @institutions << "EMEF LAERTE JOSE DOS SANTOS, PROF."
    @institutions << "EMEF LUCIANO FELICIO BIONDO, PROF."
    @institutions << "EMEF LUIZ BORTOLOSSO"
    @institutions << "EMEF MANOEL BARBOSA DE SOUZA, PROF."
    @institutions << "EMEF MANOEL TERTULIANO DE CERQUEIRA, PROF."
    @institutions << "EMEF MARINA SADDI HAIDAR"
    @institutions << "EMEF MARINA VON PUTTKAMMER MELLI"
    @institutions << "EMEF MAX ZENDRON, PROF."
    @institutions << "EMEF OLAVO ANTONIO BARBOSA SPINOLA , PROF"
    @institutions << "EMEF OLINDA MOREIRA LEMES DA CUNHA, PROFa"
    @institutions << "EMEF ONEIDE BORTOLOTE"
    @institutions << "EMEF OSCAR PENNACINO,"
    @institutions << "EMEF OSVALDO QUIRINO SIMOES"
    @institutions << "EMEF QUINTINO BOCAIUVA"
    @institutions << "EMEF RENATO FIUZA TELES, PROF."
    @institutions << "EMEF SAAD BECHARA"
    @institutions << "EMEF TECLA MERLO, IRMA"
    @institutions << "EMEF TEREZINHA MARTINS PEREIRA, PROFa"
    @institutions << "EMEF TOBIAS BARRETO DE MENEZES"
    @institutions << "EMEF VICTOR BRECHERET , ESCULTOR"
    @institutions << "CRECHE ALHA ELIAS ABIBE"
    @institutions << "CRECHE ALZIRA SILVA MEDEIROS"
    @institutions << "CRECHE AMELIA TOZZETO VIVIANE"
    @institutions << "CRECHE BENEDITA DE OLIVEIRA"
    @institutions << "CRECHE DAISY RIBEIRO NEVES"
    @institutions << "CRECHE ELZA BATISTON"
    @institutions << "CRECHE EZIO MELLI"
    @institutions << "CRECHE GIUSEPPA BERSANI MICHELIN"
    @institutions << "CRECHE HERMINIA LOPES"
    @institutions << "CRECHE HILDA ALVES DOS SANTOS MARIM"
    @institutions << "CRECHE IDA BELMONTE BISCUOLA"
    @institutions << "CRECHE INES SANCHES MENDES"
    @institutions << "CRECHE JOAO CORREA"
    @institutions << "CRECHE JOAQUINA FRANCA GARCIA, PROFa"
    @institutions << "CRECHE JOSE ESPINOSA"
    @institutions << "CRECHE JOSE CARLOS DI MAMBRO, PE."
    @institutions << "CRECHE LIDIA THOMAZ"
    @institutions << "CRECHE MARIA BENEDITA CONSTANCIO, IRMA"
    @institutions << "CRECHE MARIA JOSE DA ANUNCIACAO"
    @institutions << "CRECHE MERCEDES CORREA RUIZ BATISTA"
    @institutions << "CRECHE OLGA CAMOLESI PAVAO"
    @institutions << "CRECHE OLIMPIA MARIA DE JESUS CARVALHO"
    @institutions << "CRECHE PEDRO PENOV"
    @institutions << "CRECHE RECANTO ALEGRE "
    @institutions << "CRECHE ROSA BROSEGHINI"
    @institutions << "CRECHE ROSA PEREIRA CRE"
    @institutions << "CRECHE SADAMITU OMOSAKO"
    @institutions << "CRECHE SERAPHINA BISSOLATTI"
    @institutions << "CRECHE SERGIO ZANARDI"
    @institutions << "CRECHE SILVIA FERREIRA FARAH, PROFa"
    @institutions << "CRECHE VILMA CATAN"
    @institutions
  end

  def generate_data
    @steps = []
    @steps << ["Autenticacao", "Autenticacao"]
    @steps << ["Confirmacao segmento", "Confirmacao segmento"]
    @steps << ["Identificacao","Identificacao"]
    @steps << ["Instrucoes basicas", "Instrucoes basicas"]
    @steps << ["Ambiente ducativo", "Dimensao 1"]
    @steps << ["Ambiente fisico escolar e materiais", "Dimensao 2"]
    @steps << ["Planejamento institucional e pratica pedagogica", "Dimensao 3"]
    @steps << ["Avaliacao", "Dimensao 4"]
    @steps << ["Acesso e permanencia dos educandos na escola", "Dimensao 5"]
    @steps << ["Promocao da saude", "Dimensao 6"]
    @steps << ["Educacao socioambiental e praticas ecopedagogicas", "Dimensao 7"]
    @steps << ["Envolvimento com as familias e participacao na rede de protecao social", "Dimensao 8"]
    @steps << ["Gestao escolar democratica", "Dimensao 9"]
    @steps << ["Formação e condições de trabalho dos profissionais da escola", "Dimensao 10"]
    @steps << ["Processos de alfabetização e letramento", "Dimensao 11"]

    @dimensions = []
    @dimensions << "Ambiente educativo"
    @dimensions << "Ambiente fisico escolar e materiais"
    @dimensions << "Planejamento institucional e pratica pedagógica"
    @dimensions << "Avaliacao"
    @dimensions << "Acesso e permanencia dos educandos na escola"
    @dimensions << "Promoção da saude"
    @dimensions << "Educacao socioambiental e práticas ecopedagogicas"
    @dimensions << "Envolvimento com as familias e participacao na rede de protecao social"
    @dimensions << "Gestao escolar democratica" 
    @dimensions << "Formacao e condicoes de trabalho dos profissionais da escola"
    @dimensions << "Processos de alfabetizacao e letramento"
    
    if params[:institution_type] == "EMEF"
      generate_emef_questions
    else
      generate_creche_questions
    end
  end
  
  def generate_emef_questions
    @questions = []
    @questions[0] = []
    @questions[0][0] = {}
    @questions[0][0]["Educandos"] = []
    @questions[0][0]["Familiares"] = []
    @questions[0][0]["Familiares"] << 1
    @questions[0][0]["Familiares"] << 2
    @questions[0][0]["Funcionarios"] = []
    @questions[0][0]["Funcionarios"] << 1
    @questions[0][0]["Funcionarios"] << 2
    @questions[0][0]["Professores e Gestores"] = []
    @questions[0][0]["Professores e Gestores"] << 1
    @questions[0][0]["Professores e Gestores"] << 2
    @questions[0][1] = {}
    @questions[0][1]["Educandos"] = []
    @questions[0][1]["Familiares"] = []
    @questions[0][1]["Familiares"] << 1
    @questions[0][1]["Familiares"] << 2
    @questions[0][1]["Familiares"] << 3
    @questions[0][1]["Funcionarios"] = []
    @questions[0][1]["Funcionarios"] << 1
    @questions[0][1]["Funcionarios"] << 2
    @questions[0][1]["Funcionarios"] << 3
    @questions[0][1]["Professores e Gestores"] = []
    @questions[0][1]["Professores e Gestores"] << 1
    @questions[0][1]["Professores e Gestores"] << 2
    @questions[0][1]["Professores e Gestores"] << 3
    @questions[0][2] = {}
    @questions[0][2]["Educandos"] = []
    @questions[0][2]["Educandos"] << 1
    @questions[0][2]["Educandos"] << 2
    @questions[0][2]["Educandos"] << 3
    @questions[0][2]["Familiares"] = []
    @questions[0][2]["Familiares"] << 1
    @questions[0][2]["Familiares"] << 2
    @questions[0][2]["Familiares"] << 3
    @questions[0][2]["Funcionarios"] = []
    @questions[0][2]["Funcionarios"] << 1
    @questions[0][2]["Funcionarios"] << 2
    @questions[0][2]["Funcionarios"] << 3
    @questions[0][2]["Professores e Gestores"] = []
    @questions[0][2]["Professores e Gestores"] << 1
    @questions[0][2]["Professores e Gestores"] << 2
    @questions[0][2]["Professores e Gestores"] << 3
    @questions[0][3] = {}
    @questions[0][3]["Educandos"] = []
    @questions[0][3]["Educandos"] << 1
    @questions[0][3]["Familiares"] = []
    @questions[0][3]["Familiares"] << 1
    @questions[0][3]["Familiares"] << 2
    @questions[0][3]["Funcionarios"] = []
    @questions[0][3]["Funcionarios"] << 1
    @questions[0][3]["Funcionarios"] << 2
    @questions[0][3]["Funcionarios"] << 3
    @questions[0][3]["Professores e Gestores"] = []
    @questions[0][3]["Professores e Gestores"] << 1
    @questions[0][3]["Professores e Gestores"] << 2
    @questions[0][3]["Professores e Gestores"] << 3
    @questions[0][4] = {}
    @questions[0][4]["Educandos"] = []
    @questions[0][4]["Educandos"] << 1
    @questions[0][4]["Familiares"] = []
    @questions[0][4]["Familiares"] << 1
    @questions[0][4]["Familiares"] << 2
    @questions[0][4]["Familiares"] << 3
    @questions[0][4]["Familiares"] << 4
    @questions[0][4]["Funcionarios"] = []
    @questions[0][4]["Funcionarios"] << 1
    @questions[0][4]["Funcionarios"] << 2
    @questions[0][4]["Funcionarios"] << 3
    @questions[0][4]["Funcionarios"] << 4
    @questions[0][4]["Professores e Gestores"] = []
    @questions[0][4]["Professores e Gestores"] << 1
    @questions[0][4]["Professores e Gestores"] << 2
    @questions[0][4]["Professores e Gestores"] << 3
    @questions[0][4]["Professores e Gestores"] << 4
    @questions[0][5] = {}
    @questions[0][5]["Educandos"] = []
    @questions[0][5]["Educandos"] << 1
    @questions[0][5]["Familiares"] = []
    @questions[0][5]["Familiares"] << 1
    @questions[0][5]["Familiares"] << 2
    @questions[0][5]["Funcionarios"] = []
    @questions[0][5]["Funcionarios"] << 1
    @questions[0][5]["Funcionarios"] << 2
    @questions[0][5]["Professores e Gestores"] = []
    @questions[0][5]["Professores e Gestores"] << 1
    @questions[0][5]["Professores e Gestores"] << 2
    @questions[0][6] = {}
    @questions[0][6]["Educandos"] = []
    @questions[0][6]["Educandos"] << 2
    @questions[0][6]["Familiares"] = []
    @questions[0][6]["Familiares"] << 1
    @questions[0][6]["Familiares"] << 2
    @questions[0][6]["Funcionarios"] = []
    @questions[0][6]["Funcionarios"] << 1
    @questions[0][6]["Funcionarios"] << 2
    @questions[0][6]["Professores e Gestores"] = []
    @questions[0][6]["Professores e Gestores"] << 1
    @questions[0][6]["Professores e Gestores"] << 2
    @questions[0][7] = {}
    @questions[0][7]["Educandos"] = []
    @questions[0][7]["Educandos"] << 1
    @questions[0][7]["Educandos"] << 3
    @questions[0][7]["Familiares"] = []
    @questions[0][7]["Familiares"] << 1
    @questions[0][7]["Familiares"] << 2
    @questions[0][7]["Familiares"] << 3
    @questions[0][7]["Funcionarios"] = []
    @questions[0][7]["Funcionarios"] << 1
    @questions[0][7]["Funcionarios"] << 2
    @questions[0][7]["Funcionarios"] << 3
    @questions[0][7]["Professores e Gestores"] = []
    @questions[0][7]["Professores e Gestores"] << 1
    @questions[0][7]["Professores e Gestores"] << 2
    @questions[0][7]["Professores e Gestores"] << 3
    @questions[0][8] = {}
    @questions[0][8]["Educandos"] = []
    @questions[0][8]["Educandos"] << 1
    @questions[0][8]["Educandos"] << 2
    @questions[0][8]["Familiares"] = []
    @questions[0][8]["Familiares"] << 1
    @questions[0][8]["Familiares"] << 3
    @questions[0][8]["Funcionarios"] = []
    @questions[0][8]["Funcionarios"] << 2
    @questions[0][8]["Funcionarios"] << 3
    @questions[0][8]["Professores e Gestores"] = []
    @questions[0][8]["Professores e Gestores"] << 1
    @questions[0][8]["Professores e Gestores"] << 2
    @questions[0][9] = {}
    @questions[0][9]["Educandos"] = []
    @questions[0][9]["Familiares"] = []
    @questions[0][9]["Familiares"] << 1
    @questions[0][9]["Funcionarios"] = []
    @questions[0][9]["Funcionarios"] << 1
    @questions[0][9]["Professores e Gestores"] = []
    @questions[0][9]["Professores e Gestores"] << 1

    @questions[1] = []
    @questions[1][0] = {}
    @questions[1][0]["Educandos"] = []
    @questions[1][0]["Educandos"] << 1
    @questions[1][0]["Educandos"] << 2
    @questions[1][0]["Educandos"] << 3
    @questions[1][0]["Educandos"] << 4
    @questions[1][0]["Educandos"] << 5
    @questions[1][0]["Familiares"] = []
    @questions[1][0]["Familiares"] << 1
    @questions[1][0]["Familiares"] << 2
    @questions[1][0]["Familiares"] << 3
    @questions[1][0]["Familiares"] << 4
    @questions[1][0]["Familiares"] << 5
    @questions[1][0]["Funcionarios"] = []
    @questions[1][0]["Funcionarios"] << 1
    @questions[1][0]["Funcionarios"] << 2
    @questions[1][0]["Funcionarios"] << 3
    @questions[1][0]["Funcionarios"] << 4
    @questions[1][0]["Funcionarios"] << 5
    @questions[1][0]["Professores e Gestores"] = []
    @questions[1][0]["Professores e Gestores"] << 1
    @questions[1][0]["Professores e Gestores"] << 2
    @questions[1][0]["Professores e Gestores"] << 3
    @questions[1][0]["Professores e Gestores"] << 4
    @questions[1][0]["Professores e Gestores"] << 5
    @questions[1][1] = {}
    @questions[1][1]["Educandos"] = []
    @questions[1][1]["Educandos"] << 1
    @questions[1][1]["Educandos"] << 2
    @questions[1][1]["Educandos"] << 3
    @questions[1][1]["Familiares"] = []
    @questions[1][1]["Familiares"] << 1
    @questions[1][1]["Familiares"] << 2
    @questions[1][1]["Funcionarios"] = []
    @questions[1][1]["Funcionarios"] << 1
    @questions[1][1]["Funcionarios"] << 2
    @questions[1][1]["Funcionarios"] << 3
    @questions[1][1]["Professores e Gestores"] = []
    @questions[1][1]["Professores e Gestores"] << 1
    @questions[1][1]["Professores e Gestores"] << 2
    @questions[1][2] = {}
    @questions[1][2]["Educandos"] = []
    @questions[1][2]["Educandos"] << 1
    @questions[1][2]["Educandos"] << 2
    @questions[1][2]["Educandos"] << 3
    @questions[1][2]["Familiares"] = []
    @questions[1][2]["Familiares"] << 1
    @questions[1][2]["Familiares"] << 2
    @questions[1][2]["Familiares"] << 3
    @questions[1][2]["Funcionarios"] = []
    @questions[1][2]["Funcionarios"] << 1
    @questions[1][2]["Funcionarios"] << 2
    @questions[1][2]["Funcionarios"] << 3
    @questions[1][2]["Professores e Gestores"] = []
    @questions[1][2]["Professores e Gestores"] << 1
    @questions[1][2]["Professores e Gestores"] << 2
    @questions[1][2]["Professores e Gestores"] << 3
    @questions[1][3] = {}
    @questions[1][3]["Educandos"] = []
    @questions[1][3]["Familiares"] = []
    @questions[1][3]["Familiares"] << 3
    @questions[1][3]["Funcionarios"] = []
    @questions[1][3]["Funcionarios"] << 1
    @questions[1][3]["Funcionarios"] << 2
    @questions[1][3]["Funcionarios"] << 3
    @questions[1][3]["Professores e Gestores"] = []
    @questions[1][3]["Professores e Gestores"] << 1
    @questions[1][3]["Professores e Gestores"] << 2
    @questions[1][3]["Professores e Gestores"] << 3
    
  end

  def generate_creche_questions
    @questions = []
    @questions[0] = []
    @questions[0][0] = {}
    @questions[0][0]["Familiares"] = []
    @questions[0][0]["Familiares"] << 1
    @questions[0][0]["Familiares"] << 2
    @questions[0][0]["Funcionarios"] = []
    @questions[0][0]["Funcionarios"] << 1
    @questions[0][0]["Funcionarios"] << 2
    @questions[0][0]["Professores e Gestores"] = []
    @questions[0][0]["Professores e Gestores"] << 1
    @questions[0][0]["Professores e Gestores"] << 2
    @questions[0][1] = {}
    @questions[0][1]["Familiares"] = []
    @questions[0][1]["Familiares"] << 1
    @questions[0][1]["Familiares"] << 2
    @questions[0][1]["Familiares"] << 3
    @questions[0][1]["Funcionarios"] = []
    @questions[0][1]["Funcionarios"] << 1
    @questions[0][1]["Funcionarios"] << 2
    @questions[0][1]["Funcionarios"] << 3
    @questions[0][1]["Professores e Gestores"] = []
    @questions[0][1]["Professores e Gestores"] << 1
    @questions[0][1]["Professores e Gestores"] << 2
    @questions[0][1]["Professores e Gestores"] << 3
    @questions[0][2] = {}
    @questions[0][2]["Familiares"] = []
    @questions[0][2]["Familiares"] << 1
    @questions[0][2]["Familiares"] << 2
    @questions[0][2]["Familiares"] << 3
    @questions[0][2]["Funcionarios"] = []
    @questions[0][2]["Funcionarios"] << 1
    @questions[0][2]["Funcionarios"] << 2
    @questions[0][2]["Funcionarios"] << 3
    @questions[0][2]["Professores e Gestores"] = []
    @questions[0][2]["Professores e Gestores"] << 1
    @questions[0][2]["Professores e Gestores"] << 2
    @questions[0][2]["Professores e Gestores"] << 3
    @questions[0][3] = {}
    @questions[0][3]["Familiares"] = []
    @questions[0][3]["Familiares"] << 2
    @questions[0][3]["Familiares"] << 3
    @questions[0][3]["Funcionarios"] = []
    @questions[0][3]["Funcionarios"] << 1
    @questions[0][3]["Funcionarios"] << 2
    @questions[0][3]["Funcionarios"] << 3
    @questions[0][3]["Professores e Gestores"] = []
    @questions[0][3]["Professores e Gestores"] << 1
    @questions[0][3]["Professores e Gestores"] << 2
    @questions[0][3]["Professores e Gestores"] << 3
    @questions[0][4] = {}
    @questions[0][4]["Familiares"] = []
    @questions[0][4]["Familiares"] << 1
    @questions[0][4]["Familiares"] << 3
    @questions[0][4]["Familiares"] << 4
    @questions[0][4]["Funcionarios"] = []
    @questions[0][4]["Funcionarios"] << 1
    @questions[0][4]["Funcionarios"] << 2
    @questions[0][4]["Funcionarios"] << 4
    @questions[0][4]["Professores e Gestores"] = []
    @questions[0][4]["Professores e Gestores"] << 1
    @questions[0][4]["Professores e Gestores"] << 2
    @questions[0][4]["Professores e Gestores"] << 3
    @questions[0][4]["Professores e Gestores"] << 4
    @questions[0][5] = {}
    @questions[0][5]["Familiares"] = []
    @questions[0][5]["Familiares"] << 1
    @questions[0][5]["Familiares"] << 2
    @questions[0][5]["Funcionarios"] = []
    @questions[0][5]["Funcionarios"] << 1
    @questions[0][5]["Funcionarios"] << 2
    @questions[0][5]["Professores e Gestores"] = []
    @questions[0][5]["Professores e Gestores"] << 1
    @questions[0][5]["Professores e Gestores"] << 2
    @questions[0][6] = {}
    @questions[0][6]["Familiares"] = []
    @questions[0][6]["Familiares"] << 1
    @questions[0][6]["Familiares"] << 2
    @questions[0][6]["Funcionarios"] = []
    @questions[0][6]["Funcionarios"] << 1
    @questions[0][6]["Funcionarios"] << 2
    @questions[0][6]["Professores e Gestores"] = []
    @questions[0][6]["Professores e Gestores"] << 1
    @questions[0][6]["Professores e Gestores"] << 2
    @questions[0][7] = {}
    @questions[0][7]["Familiares"] = []
    @questions[0][7]["Familiares"] << 1
    @questions[0][7]["Familiares"] << 2
    @questions[0][7]["Familiares"] << 3
    @questions[0][7]["Familiares"] << 4
    @questions[0][7]["Funcionarios"] = []
    @questions[0][7]["Funcionarios"] << 1
    @questions[0][7]["Funcionarios"] << 2
    @questions[0][7]["Funcionarios"] << 3
    @questions[0][7]["Funcionarios"] << 4
    @questions[0][7]["Professores e Gestores"] = []
    @questions[0][7]["Professores e Gestores"] << 1
    @questions[0][7]["Professores e Gestores"] << 2
    @questions[0][7]["Professores e Gestores"] << 3
    @questions[0][7]["Professores e Gestores"] << 4
    @questions[0][8] = {}
    @questions[0][8]["Familiares"] = []
    @questions[0][8]["Familiares"] << 1
    @questions[0][8]["Familiares"] << 2
    @questions[0][8]["Familiares"] << 3
    @questions[0][8]["Funcionarios"] = []
    @questions[0][8]["Funcionarios"] << 1
    @questions[0][8]["Funcionarios"] << 2
    @questions[0][8]["Funcionarios"] << 3
    @questions[0][8]["Professores e Gestores"] = []
    @questions[0][8]["Professores e Gestores"] << 1
    @questions[0][8]["Professores e Gestores"] << 2
    @questions[0][8]["Professores e Gestores"] << 3
    @questions[0][9] = {}
    @questions[0][9]["Familiares"] = []
    @questions[0][9]["Funcionarios"] = []
    @questions[0][9]["Funcionarios"] << 1
    @questions[0][9]["Funcionarios"] << 2
    @questions[0][9]["Professores e Gestores"] = []
    @questions[0][9]["Professores e Gestores"] << 1
    @questions[0][9]["Professores e Gestores"] << 2
    @questions[0][10] = {}
    @questions[0][10]["Familiares"] = []
    @questions[0][10]["Familiares"] << 2
    @questions[0][10]["Familiares"] << 3
    @questions[0][10]["Funcionarios"] = []
    @questions[0][10]["Funcionarios"] << 1
    @questions[0][10]["Funcionarios"] << 2
    @questions[0][10]["Funcionarios"] << 3
    @questions[0][10]["Funcionarios"] << 4
    @questions[0][10]["Professores e Gestores"] = []
    @questions[0][10]["Professores e Gestores"] << 1
    @questions[0][10]["Professores e Gestores"] << 2
    @questions[0][10]["Professores e Gestores"] << 3
    @questions[0][10]["Professores e Gestores"] << 4

    @questions[1] = []
    @questions[1][0] = {}
    @questions[1][0]["Familiares"] = []
    @questions[1][0]["Familiares"] << 1
    @questions[1][0]["Familiares"] << 2
    @questions[1][0]["Familiares"] << 3
    @questions[1][0]["Familiares"] << 4
    @questions[1][0]["Funcionarios"] = []
    @questions[1][0]["Funcionarios"] << 1
    @questions[1][0]["Funcionarios"] << 2
    @questions[1][0]["Funcionarios"] << 3
    @questions[1][0]["Funcionarios"] << 4
    @questions[1][0]["Professores e Gestores"] = []
    @questions[1][0]["Professores e Gestores"] << 1
    @questions[1][0]["Professores e Gestores"] << 2
    @questions[1][0]["Professores e Gestores"] << 3
    @questions[1][0]["Professores e Gestores"] << 4
    @questions[1][1] = {}
    @questions[1][1]["Familiares"] = []
    @questions[1][1]["Familiares"] << 1
    @questions[1][1]["Familiares"] << 2
    @questions[1][1]["Familiares"] << 3
    @questions[1][1]["Familiares"] << 4
    @questions[1][1]["Funcionarios"] = []
    @questions[1][1]["Funcionarios"] << 1
    @questions[1][1]["Funcionarios"] << 2
    @questions[1][1]["Funcionarios"] << 3
    @questions[1][1]["Funcionarios"] << 4
    @questions[1][1]["Professores e Gestores"] = []
    @questions[1][1]["Professores e Gestores"] << 1
    @questions[1][1]["Professores e Gestores"] << 2
    @questions[1][1]["Professores e Gestores"] << 3
    @questions[1][1]["Professores e Gestores"] << 4
    @questions[1][2] = {}
    @questions[1][2]["Familiares"] = []
    @questions[1][2]["Familiares"] << 1
    @questions[1][2]["Familiares"] << 2
    @questions[1][2]["Familiares"] << 3
    @questions[1][2]["Familiares"] << 4
    @questions[1][2]["Funcionarios"] = []
    @questions[1][2]["Funcionarios"] << 1
    @questions[1][2]["Funcionarios"] << 2
    @questions[1][2]["Funcionarios"] << 3
    @questions[1][2]["Funcionarios"] << 4
    @questions[1][2]["Professores e Gestores"] = []
    @questions[1][2]["Professores e Gestores"] << 1
    @questions[1][2]["Professores e Gestores"] << 2
    @questions[1][2]["Professores e Gestores"] << 3
    @questions[1][2]["Professores e Gestores"] << 4
    @questions[1][3] = {}
    @questions[1][3]["Familiares"] = []
    @questions[1][3]["Familiares"] << 3
    @questions[1][3]["Familiares"] << 4
    @questions[1][3]["Funcionarios"] = []
    @questions[1][3]["Funcionarios"] << 1
    @questions[1][3]["Funcionarios"] << 2
    @questions[1][3]["Funcionarios"] << 3
    @questions[1][3]["Professores e Gestores"] = []
    @questions[1][3]["Professores e Gestores"] << 1
    @questions[1][3]["Professores e Gestores"] << 2
    @questions[1][3]["Professores e Gestores"] << 3

  end

end
