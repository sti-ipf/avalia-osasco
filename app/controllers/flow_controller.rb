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
    elsif(params[:password] == '2ws9om' && @institution == "EMEF ALIPIO DA SILVA LAVOURA, PROF.")
      @segment = "Funcionarios"
      render "confirm"
    elsif(params[:password] == '3ed8ik' && @institution == "EMEF ANEZIO CABRAL, PROF.")
      @segment = "Educando"
      render "confirm"
    elsif(params[:password] == '4rf7uj' && @institution == "CRECHE ALHA ELIAS ABIBE")
      @segment = "Familiares"
      render "confirm"
    elsif(params[:password] == '5tg6yh' && @institution == "CRECHE ALZIRA SILVA MEDEIROS")
      @segment = "Professores e Gestores"
      render "confirm"
    elsif(params[:password] == 'zxcmnb' && @institution == "CRECHE AMELIA TOZZETO VIVIANE")
      @segment = "Funcionarios"
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
    @institutions << "EMEF ALIPIO DA SILVA LAVOURA, PROF."
    @institutions << "EMEF ANEZIO CABRAL, PROF."
    @institutions << "EMEF ANTONIO DE SAMPAIO, GENERAL"
    @institutions << "EMEF BENEDICTO WESCHENFELDER"
    @institutions << "EMEF BENEDITO ALVES TURIBIO"
    @institutions << "EMEF BITTENCOURT, MARECHAL"
    @institutions << "EMEF CECILIA CORREA CASTELANI, PROFa"
    @institutions << "EMEF DOMINGOS BLASCO, MAESTRO"
    @institutions << "EMEF ELIDIO MANTOVANI, MONSENHOR"
    @institutions << "EMEF ELZA DE CARVALHO MELLO BATTISTON, PROFª"
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
    @institutions << "EMEF OLINDA MOREIRA LEMES DA CUNHA, PROFª"
    @institutions << "EMEF ONEIDE BORTOLOTE"
    @institutions << "EMEF OSCAR PENNACINO,"
    @institutions << "EMEF OSVALDO QUIRINO SIMÕES"
    @institutions << "EMEF QUINTINO BOCAIUVA"
    @institutions << "EMEF RENATO FIUZA TELES, PROF."
    @institutions << "EMEF SAAD BECHARA"
    @institutions << "EMEF TECLA MERLO, IRMA"
    @institutions << "EMEF TEREZINHA MARTINS PEREIRA, PROFª"
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
    @institutions << "CRECHE JOAQUINA FRANÇA GARCIA, PROFª"
    @institutions << "CRECHE JOSE ESPINOSA"
    @institutions << "CRECHE JOSE CARLOS DI MAMBRO, PE."
    @institutions << "CRECHE LIDIA THOMAZ"
    @institutions << "CRECHE MARIA BENEDITA CONSTÂNCIO, IRMA"
    @institutions << "CRECHE MARIA JOSE DA ANUNCIAÇAO"
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
  end
end
