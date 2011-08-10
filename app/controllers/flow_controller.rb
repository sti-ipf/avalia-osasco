class FlowController < ApplicationController
  def index
    generate_institutions
  end
  
  def authenticate
    @institution = params[:institution]
    if(params[:password] == '123456' && @institution == "EMEF ALFREDO FARHAT, DEPUTADO")
      @segment = "Familiares"
      render "confirm"
    elsif(params[:password] == '1qa0pk' && @institution == "EMEF ALICE RABECHINI FERREIRA")
      @segment = "Professores e Gestores"
      render "confirm"
    elsif(params[:password] == '2ws9om' && @institution == "EMEF ALÍPIO DA SILVA LAVOURA, PROF.")
      @segment = "Funcionários"
      render "confirm"
    elsif(params[:password] == '3ed8ik' && @institution == "EMEF ANÉZIO CABRAL, PROF.")
      @segment = "Educando"
      render "confirm"
    elsif(params[:password] == '4rf7uj' && @institution == "CRECHE ALHA ELIAS ABIBE")
      @segment = "Familiares"
      render "confirm"
    elsif(params[:password] == '5tg6yh' && @institution == "CRECHE ALZIRA SILVA MEDEIROS")
      @segment = "Professores e Gestores"
      render "confirm"
    elsif(params[:password] == 'zxcmnb' && @institution == "CRECHE AMÉLIA TOZZETO VIVIANE")
      @segment = "Funcionários"
      render "confirm"
    elsif(params[:password] == 'zxc098' && @institution == "CRECHE BENEDITA DE OLIVEIRA")
      @segment = "Educando"
      render "confirm"
    else
      generate_institutions
      render "index"
    end
  end

  def identify
    @institution = params[:institution]
    @segment = params[:segment]
    if(params[:commit] == 'sim')
      render "identify"
    else
      generate_institutions
      render "index"
    end
  end

  def instructions
    @institution = params[:institution]
    @segment = params[:segment]
    @name = params[:name]
    render "instructions"
  end

  def answerdimension
    @institution = params[:institution]
    @segment = params[:segment]
    @name = params[:name]
    generate_questions
    render "answer"
  end

  def review
    @institution = params[:institution]
    @segment = params[:segment]
    @name = params[:name]
    generate_questions
    render "review"
  end

  def checkreview
    @institution = params[:institution]
    @segment = params[:segment]
    @name = params[:name]
    if(params[:commit] == 'modificar')
      generate_questions
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
    @institutions << "EMEF ALÍPIO DA SILVA LAVOURA, PROF."
    @institutions << "EMEF ANÉZIO CABRAL, PROF."
    @institutions << "EMEF ANTONIO DE SAMPAIO, GENERAL"
    @institutions << "EMEF BENEDICTO WESCHENFELDER"
    @institutions << "EMEF BENEDITO ALVES TURÍBIO"
    @institutions << "EMEF BITTENCOURT, MARECHAL"
    @institutions << "EMEF CECÍLIA CORREA CASTELANI, PROFª"
    @institutions << "EMEF DOMINGOS BLASCO, MAESTRO"
    @institutions << "EMEF ELÍDIO MANTOVANI, MONSENHOR"
    @institutions << "EMEF ELZA DE CARVALHO MELLO BATTISTON, PROFª"
    @institutions << "EMEF FRANCISCO CAVALCANTI PONTES DE MIRANDA"
    @institutions << "EMEF FRANCISCO MANUEL LUMBRALES DE SÁ CARNEIRO, DR."
    @institutions << "EMEF GASPAR DA MADRE DE DEUS, FREI"
    @institutions << "EMEF HUGO RIBEIRO DE ALMEIDA, DR."
    @institutions << "EMEF JOÃO CAMPESTRINI, PROF."
    @institutions << "EMEF JOÃO EUCLYDES PEREIRA, PROF."
    @institutions << "EMEF JOÃO GUIMARÃES ROSA"
    @institutions << "EMEF JOÃO LARIZZATTI, PROF."
    @institutions << "EMEF JOSÉ GROSSI DIAS, PADRE"
    @institutions << "EMEF JOSÉ MANOEL AYRES, DR."
    @institutions << "EMEF JOSÉ MARTINIANO DE ALENCAR"
    @institutions << "EMEF JOSÉ VERÍSSIMO DE MATOS"
    @institutions << "EMEF JOSIAS BAPTISTA, PASTOR"
    @institutions << "EMEF LAERTE JOSÉ DOS SANTOS, PROF."
    @institutions << "EMEF LUCIANO FELÍCIO BIONDO, PROF."
    @institutions << "EMEF LUIZ BORTOLOSSO"
    @institutions << "EMEF MANOEL BARBOSA DE SOUZA, PROF."
    @institutions << "EMEF MANOEL TERTULIANO DE CERQUEIRA, PROF."
    @institutions << "EMEF MARINA SADDI HAIDAR"
    @institutions << "EMEF MARINA VON PUTTKAMMER MELLI"
    @institutions << "EMEF MAX ZENDRON, PROF."
    @institutions << "EMEF OLAVO ANTÔNIO BARBOSA SPÍNOLA , PROF"
    @institutions << "EMEF OLINDA MOREIRA LEMES DA CUNHA, PROFª"
    @institutions << "EMEF ONEIDE BORTOLOTE"
    @institutions << "EMEF OSCAR PENNACINO,"
    @institutions << "EMEF OSVALDO QUIRINO SIMÕES"
    @institutions << "EMEF QUINTINO BOCAIÚVA"
    @institutions << "EMEF RENATO FIUZA TELES, PROF."
    @institutions << "EMEF SAAD BECHARA"
    @institutions << "EMEF TECLA MERLO, IRMÃ"
    @institutions << "EMEF TEREZINHA MARTINS PEREIRA, PROFª"
    @institutions << "EMEF TOBIAS BARRETO DE MENEZES"
    @institutions << "EMEF VICTOR BRECHERET , ESCULTOR"
    @institutions << "CRECHE ALHA ELIAS ABIBE"
    @institutions << "CRECHE ALZIRA SILVA MEDEIROS"
    @institutions << "CRECHE AMÉLIA TOZZETO VIVIANE"
    @institutions << "CRECHE BENEDITA DE OLIVEIRA"
    @institutions << "CRECHE DAISY RIBEIRO NEVES"
    @institutions << "CRECHE ELZA BATISTON"
    @institutions << "CRECHE EZIO MELLI"
    @institutions << "CRECHE GIUSEPPA BERSANI MICHELIN"
    @institutions << "CRECHE HERMÍNIA LOPES"
    @institutions << "CRECHE HILDA ALVES DOS SANTOS MARIM"
    @institutions << "CRECHE IDA BELMONTE BISCUOLA"
    @institutions << "CRECHE INÊS SANCHES MENDES"
    @institutions << "CRECHE JOÃO CORRÊA"
    @institutions << "CRECHE JOAQUINA FRANÇA GARCIA, PROFª"
    @institutions << "CRECHE JOSÉ ESPINOSA"
    @institutions << "CRECHE JOSÉ CARLOS DI MAMBRO, PE."
    @institutions << "CRECHE LIDIA THOMAZ"
    @institutions << "CRECHE MARIA BENEDITA CONSTÂNCIO, IRMÃ"
    @institutions << "CRECHE MARIA JOSÉ DA ANUNCIAÇÃO"
    @institutions << "CRECHE MERCEDES CORRÊA RUIZ BATISTA"
    @institutions << "CRECHE OLGA CAMOLESI PAVÃO"
    @institutions << "CRECHE OLÍMPIA MARIA DE JESUS CARVALHO"
    @institutions << "CRECHE PEDRO PENOV"
    @institutions << "CRECHE RECANTO ALEGRE "
    @institutions << "CRECHE ROSA BROSEGHINI"
    @institutions << "CRECHE ROSA PEREIRA CRÊ"
    @institutions << "CRECHE SADAMITU OMOSAKO"
    @institutions << "CRECHE SERAPHINA BISSOLATTI"
    @institutions << "CRECHE SERGIO ZANARDI"
    @institutions << "CRECHE SILVIA FERREIRA FARAH, PROFª"
    @institutions << "CRECHE VILMA CATAN"
    @institutions
  end

  def generate_questions
    @questions = []
    @questions[0] = []
    @questions[0][0] = {}
    @questions[0][0]["Educandos"] = []
    @questions[0][0]["Familiares"] = []
    @questions[0][0]["Familiares"] << 1
    @questions[0][0]["Familiares"] << 2
    @questions[0][0]["Funcionários"] = []
    @questions[0][0]["Funcionários"] << 1
    @questions[0][0]["Funcionários"] << 2
    @questions[0][0]["Professores e Gestores"] = []
    @questions[0][0]["Professores e Gestores"] << 1
    @questions[0][0]["Professores e Gestores"] << 2
    @questions[0][1] = {}
    @questions[0][1]["Educandos"] = []
    @questions[0][1]["Familiares"] = []
    @questions[0][1]["Familiares"] << 1
    @questions[0][1]["Familiares"] << 2
    @questions[0][1]["Familiares"] << 3
    @questions[0][1]["Funcionários"] = []
    @questions[0][1]["Funcionários"] << 1
    @questions[0][1]["Funcionários"] << 2
    @questions[0][1]["Funcionários"] << 3
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
    @questions[0][2]["Funcionários"] = []
    @questions[0][2]["Funcionários"] << 1
    @questions[0][2]["Funcionários"] << 2
    @questions[0][2]["Funcionários"] << 3
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
    @questions[0][3]["Funcionários"] = []
    @questions[0][3]["Funcionários"] << 1
    @questions[0][3]["Funcionários"] << 2
    @questions[0][3]["Funcionários"] << 3
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
    @questions[0][4]["Funcionários"] = []
    @questions[0][4]["Funcionários"] << 1
    @questions[0][4]["Funcionários"] << 2
    @questions[0][4]["Funcionários"] << 3
    @questions[0][4]["Funcionários"] << 4
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
    @questions[0][5]["Funcionários"] = []
    @questions[0][5]["Funcionários"] << 1
    @questions[0][5]["Funcionários"] << 2
    @questions[0][5]["Professores e Gestores"] = []
    @questions[0][5]["Professores e Gestores"] << 1
    @questions[0][5]["Professores e Gestores"] << 2
    @questions[0][6] = {}
    @questions[0][6]["Educandos"] = []
    @questions[0][6]["Educandos"] << 2
    @questions[0][6]["Familiares"] = []
    @questions[0][6]["Familiares"] << 1
    @questions[0][6]["Familiares"] << 2
    @questions[0][6]["Funcionários"] = []
    @questions[0][6]["Funcionários"] << 1
    @questions[0][6]["Funcionários"] << 2
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
    @questions[0][7]["Funcionários"] = []
    @questions[0][7]["Funcionários"] << 1
    @questions[0][7]["Funcionários"] << 2
    @questions[0][7]["Funcionários"] << 3
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
    @questions[0][8]["Funcionários"] = []
    @questions[0][8]["Funcionários"] << 2
    @questions[0][8]["Funcionários"] << 3
    @questions[0][8]["Professores e Gestores"] = []
    @questions[0][8]["Professores e Gestores"] << 1
    @questions[0][8]["Professores e Gestores"] << 2
    @questions[0][9] = {}
    @questions[0][9]["Educandos"] = []
    @questions[0][9]["Familiares"] = []
    @questions[0][9]["Familiares"] << 1
    @questions[0][9]["Funcionários"] = []
    @questions[0][9]["Funcionários"] << 1
    @questions[0][9]["Professores e Gestores"] = []
    @questions[0][9]["Professores e Gestores"] << 1
  end
end
