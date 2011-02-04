require "open-uri"

class ReportIndividual
# estilos
  STYLES = {
             :titulo => {  :align => :center, :style => :bold, :size => 16 },
             :chapitulo => { :align => :left, :style => :bold, :size => 14 },
             :secao => { :align => :left, :size => 13 },
             :texto =>  { :size => 11, :indent_paragraphs => 40, :style => :normal },
             :centro => { :align => :center }
           }

  def to_pdf(ue,answers,service_level) 
    Prawn::Document.generate("#{RAILS_ROOT}/public/relatorios/#{ue.name}_#{service_level.name}.pdf", :margin => [30, 30, 30, 30]) do
#  def small_cell(text)
#    { :text => text, :size => 9 }
#  end



#################################################################################
# configurações de formatação
# font
  font_families.update(
              "pt sans" => {:normal => "#{RAILS_ROOT}/public/fonts/PT_Sans-Regular.ttf",
                            :bold => "#{RAILS_ROOT}/public/fonts/PT_Sans-Bold.ttf", 
                            :italic => "#{RAILS_ROOT}/public/fonts/PT_Sans-Italic.ttf", 
                            :bolditalic => "#{RAILS_ROOT}/public/fonts/PT_Sans-BoldItalic.ttf"} 
  )
  font "pt sans" 

# format
repeat :all do
  header = "#{RAILS_ROOT}/public/images/cabecalho.jpg"
  footer = "#{RAILS_ROOT}/public/images/rodape.png"
#  image header, :at => [0,770], :scale => 0.75
  image footer, :at => [350,50], :scale => 0.75
end


##########################################################################################
# inicio do texto
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  text "\n RESULTADOS DA AVALIAÇÃO EDUCACIONAL 2010", :align => :center, :size => 16, :style => :bold
      text "\n Unidade Educacional da Rede Municipal de Osasco: 
UNIDADE EDUCACIONAL", :align => :center, :size => 15, :style => :bold
# text "#{service_level.name}", :align => :center, :size => 15, :style => :bold
  text "\n Sumário", :align => :center, :size => 13
  fill_color "4e0d0d"
  text "\n 1 ORIENTAÇÕES GERAIS", :style => :bold
  fill_color "000000"
text "1.1 Qual a importância da avaliação educacional na rede?
1.2 Como está organizado o relatório de avaliação de cada unidade educacional?
1.3 Como analisar e utilizar os resultados da avaliação apresentados neste relatório?
1.4 É possível articular a avaliação educacional com as novas orientações curriculares?
1.5 As unidades educacionais podem comparar sua avaliação com as demais da rede?"

  fill_color "4e0d0d"
  text "\n 2 RESULTADOS DA AVALIAÇÃO EDUCACIONAL DA SUA UNIDADE", :style => :bold
  fill_color "043ccb"
  text "\n 2.1 DIMENSÃO 1 - AMBIENTE EDUCATIVO", :style => :bold
  fill_color "0000000"
  text "2.1.1 Percepção da UE sobre a dimensão
	2.1.2 Percepção da UE sobre cada indicador de qualidade
	2.1.3 Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar 
	2.1.4 Questões problematizadoras"
  
  fill_color "043ccb"
  text "\n 2.2 DIMENSÃO 2 - AMBIENTE FÍSICO ESCOLAR E MATERIAIS", :style => :bold
  fill_color "0000000"
  text "2.2.1 Percepção da UE sobre a dimensão
	2.2.2 Percepção da UE sobre cada indicador de qualidade
	2.2.3 Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar 
	2.2.4 Questões problematizadoras"

  fill_color "043ccb"
  text "\n 2.3 DIMENSÃO 3 - PLANEJAMENTO INSTITUCIONAL E PRÁTICA PEDAGÓGICA", :style => :bold
  fill_color "0000000"
  text "2.3.1 Percepção da UE sobre a dimensão
	2.3.2 Percepção da UE sobre cada indicador de qualidade
	2.3.3 Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar 
	2.3.4 Questões problematizadoras"

  fill_color "043ccb"
  text "\n 2.4 DIMENSÂO 4 - AVALIAÇÃO", :style => :bold
  fill_color "0000000"
  text "2.4.1 Percepção da UE sobre a dimensão
	2.4.2 Percepção da UE sobre cada indicador de qualidade
	2.4.3 Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar 
	2.4.4 Questões problematizadoras"
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  move_down(5)
  fill_color "043ccb"
  text "\n 2.5 DIMENSÃO 5 - ACESSO E PERMANÊNCIA DOS EDUCANDOS NA ESCOLA", :style => :bold
  fill_color "0000000"
  text "2.5.1 Percepção da UE sobre a dimensão
	2.5.2 Percepção da UE sobre cada indicador de qualidade
	2.5.3 Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar 
	2.5.4 Questões problematizadoras"

  fill_color "043ccb"
  text "\n 2.6 DIMENSÃO 6 - PROMOÇÃO DA SAÚDE ", :style => :bold
  fill_color "0000000"
  text "2.6.1 Percepção da UE sobre a dimensão
	2.6.2 Percepção da UE sobre cada indicador de qualidade
	2.6.3 Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar
	2.6.4 Questões problematizadoras"
	

  fill_color "043ccb"
  text "\n 2.7 DIMENSÃO 7 - EDUCAÇÃO SOCIOAMBIENTAL E PRÁTICAS ECOPEDAGÓGICAS", :style => :bold
  fill_color "0000000"
  text "2.7.1 Percepção da UE sobre a dimensão
	2.7.2 Percepção da UE sobre cada indicador de qualidade
	2.7.3 Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar 
	2.7.4 Questões problematizadoras"

  fill_color "043ccb"
  text "\n 2.8 DIMENSÃO 8 - ENVOLVIMENTO COM AS FAMÍLIAS E PARTICIPAÇÃO NA REDE DE PROTEÇÃO SOCIAL", :style => :bold
  fill_color "0000000"
  text "2.8.1 Percepção da UE sobre a dimensão
	2.8.2 Percepção da UE sobre cada indicador de qualidade
	2.8.3 Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar 
	2.8.4 Questões problematizadoras"

  fill_color "043ccb"
  text "\n 2.9 DIMENSÂO 9 - GESTÂO ESCOLAR DEMOCRÁTICA", :style => :bold
  fill_color "0000000"
  text "2.9.1 Percepção da UE sobre a dimensão
	2.9.2 Percepção da UE sobre cada indicador de qualidade
	2.9.3 Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar 
	2.9.4 Questões problematizadoras"

  fill_color "043ccb"
  text "\n 2.10 DIMENSÃO 10 - FORMAÇÃO E CONDIÇÕES DE TRABALHO DOS PROFISSIONAIS DA ESCOLA", :style => :bold
  fill_color "0000000"
  text "2.10.1 Percepção da UE sobre a dimensão
	2.10.2 Percepção da UE sobre cada indicador de qualidade
	2.10.3 Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar 
	2.10.4 Questões problematizadoras"

  fill_color "043ccb"
  text "\n 2.11 DIMENSÃO 11 - PROCESSOS DE ALFABETIZAÇÃO E LETRAMENTO", :style => :bold
  fill_color "0000000"
  text "2.11.1 Percepção da UE sobre a dimensão
	2.11.2 Percepção da UE sobre cada indicador de qualidade
	2.11.3 Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar 
	2.11.4 Questões problematizadoras"

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  move_down(5)

  fill_color "4e0d0d"
  text "\n 4 QUADRO DE ÍNDICES DA SUA UNIDADE EDUCACIONAL EM COMPARAÇÃO COM A REDE

	5 ENCAMINHAMENTOS PARA O PLANO DE TRABALHO ANUAL DE 2011

	6 QUADRO DE EQUIVALÊNCIA DE QUESTÕES DE CADA DIMENSÃO, POR SEGMENTO ESCOLAR", :style => :bold

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  fill_color "4e0d0d"
  text "\n 1 ORIENTAÇÕES GERAIS", :style => :bold, :size => 14
  fill_color "043ccb"
  text "\n 1.1 Qual a importância da avaliação educacional na Rede?", :style => :bold, :size => 14
  fill_color "0000000"
  text "A prática da avaliação educacional que se consolida  na rede municipal de Osasco vem contribuindo para que as unidades educacionais alcancem compreensão coletiva dos acertos e dificuldades vividos no ano que passou e possam planejar as ações transformadoras que todos desejam concretizar.", :indent_paragraphs => 40
  text "Ao considerarmos o ato de educar como uma prática social que se dá dentro de um campo de intencionalidades, a experiência da avaliação do ano letivo de 2010 ofereceu a todos ricas oportunidades para, agora, no início de mais um ano letivo, estabelecer objetivos claros para as ações cotidianas da unidade educacional. Diante do que a avaliação revelar acerca das práticas educativas nela desenvolvidas, as pessoas que integram a comunidade escolar poderão priorizar determinadas ações, elaborar projetos específicos e assumir intenções educativas próprias que alcancem novos resultados pedagógicos.", :indent_paragraphs => 40
  text "No processo de avaliação educacional vivido em 2010, o empenho das U.E. em assegurar a todos um experiência significativa, democrática e emancipadora foi notável. E o resultados de todo esse empenho é apresentado nesse documento.", :indent_paragraphs => 40
  text "Na semana de planejamento prevista para o início de fevereiro, as equipes escolares devem se reunir para analisar este relatório, refletir sobre os dados que ele apresenta, podendo para isso, valer-se das questões problematizadoras sugeridas para cada uma das 11 dimensões avaliadas. É preciso ainda garantir que os familiares e alunos vivenciem um momento de análise dos resultados da avaliação, propondo ações para a melhoria da qualidade do atendimento educacional prestado à população.", :indent_paragraphs => 40
  text "Ao identificar os desafios que a unidade buscará superar em 2011, o próximo passo será planejar, no âmbito do Plano de Trabalho anual (PTA), as ações, os prazos e os responsáveis pela sua execução, valendo-se ainda da proposta preliminar da RECEI e RECEF e das contribuições das crianças para uma melhor gestão educacional, presentes no relatório da III Conferência Lúdica.", :indent_paragraphs => 40
  text "É certo que, com todo este movimento, cada unidade se aproxima mais da escola desejada por sua comunidade e a rede municipal de Osasco avança cada vez mais rumo a uma Escola cidadã e Inclusiva.", :indent_paragraphs => 40

  fill_color "043ccb"
  text "\n 1.2 Como está organizado o relatório de avaliação de cada unidade educacional?", :size => 14, :style => :bold
  fill_color "0000000"
  text "Este relatório apresenta os resultados da avaliação feita pela sua unidade educacional em 2010. Para Paulo Freire, “o meu contexto determina a leitura do texto” e dependendo do contexto de onde partimos, diferentes análises e interpretações podem ser feitas. Nesse sentido, a proposta de análise aqui apresentada precisa ser ajustada a cada realidade educacional para, a partir dos diferentes olhares nela presentes, descobrir formas próprias de interpretação dos dados e construir os caminhos a serem percorridos por todos no âmbito do Plano de Trabalho Anual de 2011.", :indent_paragraphs => 40
  text "A estrutura deste relatório segue a mesma organização do instrumental de avaliação utilizado pelas unidades educacionais para o registro das suas opiniões em 2010. Conforme indicado no sumário, na parte: RESULTADOS DA AVALIAÇÃO EDUCACIONAL DA SUA UNIDADE, as opiniões da sua comunidade escolar sobre o ano letivo de 2010, expressas numericamente, serão demonstradas da seguinte forma:", :indent_paragraphs => 40

  text "\n Identificação da Dimensão:", :style => :bold
  text "Nome e breve contextualização da dimensão avaliada"

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  text "\n Percepção da UE sobre a Dimensão", :style => :bold
  text "Nestes gráficos podemos analisar o resultado das médias da dimensão por segmento, tendo como referência os resultados do nível de ensino do grupo de análise que cada UE faz parte. O gráfico de cada dimensão apresenta informações para cada segmento.", :indent_paragraphs => 40
  text "As primeiras colunas correspondem à média das respostas de cada segmento da unidade escolar: educandos, familiares, funcionários, gestores e professores.", :indent_paragraphs => 40
  text "A penúltima coluna corresponde à média geral das respostas da UE.", :indent_paragraphs => 40
  text "A última coluna corresponde à média das respostas do segmento de seu grupo de unidades educacionais a que faz parte.", :indent_paragraphs => 40

  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
  text "Gráficos que apresentam a médias de cada indicador de qualidade por segmento, tendo como referência os resultados do nível de ensino do grupo de unidades educacionais a que faz parte. A organização dos gráficos em colunas é a mesma dos gráficos das dimensões.", :indent_paragraphs => 40

  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar", :style => :bold
  text "Quadro que apresenta a média das opiniões numéricas atribuídas a cada questão pelos segmentos escolares participantes da avaliação. É importante ressaltar que a quantidade de questões formuladas a cada segmento foi diferente. Por essa razão, alguns campos do quadro estarão com zero. A descrição de cada pergunta indicada no quadro poderá ser vista no “quadro de equivalência de questões de cada dimensão, por segmento escolar” - documento disponível em arquivo no CD-ROM.", :indent_paragraphs => 40

  text "\n Questões problematizadoras", :style => :bold
  text "Ao final de cada dimensão, algumas questões são sugeridas para uma reflexão acerca da dimensão.", :indent_paragraphs => 40

  fill_color "043ccb"
  text "\n 1.3 Como analisar e utilizar os resultados da avaliação apresentados neste relatório?", :style => :bold, :size => 14
  fill_color "000000"
  text "A avaliação feita pela sua unidade educacional foi bastante ampla e envolveu assuntos diversos. Para uma adequada análise e apropriação dos dados aqui revelados, é fundamental que a equipe escolar organize pequenos grupos de estudo deste documento, distribuindo entre eles um conjunto de dimensões, de modo que possam, detidamente, analisar a avaliação como um todo.", :indent_paragraphs => 40
  text "Para contribuir com esse momento de análise, segue abaixo problematizações iniciais que os grupos de estudo podem utilizar. Ao final dos dados de cada dimensão, o documento também sugere problematizações específicas.", :indent_paragraphs => 40
  text "\n ● Analisando os indicadores de qualidade e a dimensão em questão, quais tiveram resultado abaixo do esperado pelo grupo? Estes indicadores e esta dimensão merecem uma atenção especial da unidade em seu PTA? Quais fatores podem ter contribuído para o resultado apresentado? É possível identificarmos o que está influenciando estes resultados? O que pode ser planejado para  melhorar estes indicadores?"
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  text "\n ● Os resultados das médias são muito diferentes entre cada segmento?  As médias resultantes da avaliação entre os segmentos,estão próximas ou muito diferentes? o que isto pode nos indicar? No PTA, sem descuidar das ações que estão apresentando bons resultados, será necessário criar ações para que cada segmento atue prioritariamente nos indicadores que tiveram uma avaliação muito baixa, lembrando que se trata de um esforço coletivo para superar problemas e não para punir."
  text "\n ● Quais questões exerceram maior influência no resultado da média dos indicadores?"
  text "\n ● Que ações podem ser previstas em 2011 para melhorar a dimensão em questão?"

  fill_color "043ccb"
  text "\n 1.4 É possível articular a avaliação educacional com as novas orientações curriculares?", :style => :bold, :size => 14
  fill_color "000000"
  text "Durante a análise dos resultados da avaliação 2010 da sua unidade, é fundamental que os aspectos educacionais a serem melhorados sejam construídos em coerência com as novas orientações curriculares em construção na Rede. Os caminhos a serem trilhados pela equipe escolar para a melhoria da qualidade dos serviços educacionais precisam se mostrar coerentes com os pressupostos da atual política educacional em desenvolvimento. ", :indent_paragraphs => 40
  text "Se de um lado temos a avaliação educacional que indica o lugar e o momento vivido pela sua unidade educacional, do outro lado temos a proposta curricular em construção que já sinaliza certos horizontes que o coletivo docente da Rede quer alcançar. O plano de trabalho anual de 2011 deve ser entendido como o meio a ser utilizado pela sua unidade para se aproximar desse horizonte.", :indent_paragraphs => 40
  text "Para tanto, listamos abaixo princípios que caracterizam a proposta curricular em discussão na Rede:", :indent_paragraphs => 40
  text "\n  ●  Os tempos de aprendizagem: Quando se pensa em tempos que devem ser assegurados aos educandos e educandas no processo de ensino e aprendizagem, busca-se o desenvolvimento de uma educação de qualidade sociocultural e socioambiental, intimamente relacionado à garantia do tempo de que a criança precisa para alcançar as aprendizagens pretendidas, pois cada criança tem um ritmo próprio."

  text "\n  ● Os espaços de aprendizagem: O espaço deve ser compreendido como um lugar de encontros. Encontro das culturas, da diversidade, de pessoas que trazem consigo conhecimentos e aprendizagens acumulados ao longo de suas vidas. Os espaços devem ser intencionalmente organizados por educadores e educadoras com a finalidade de disponibilizar uma maior oferta de vivências interessantes, possibilitando a formação de crianças mais autônomas,  que sabem fazer escolhas individuais e,  gradativamente, aprendem a compartilhar  experiências coletivas."

  text "\n  ● A expressão da criança: “se na entrada da escola, a criança encontra um painel com fotos suas e de seus colegas, ela se sente parte do lugar. Se, em lugar de fotos, o painel tem um desenho seu, uma pintura, uma modelagem de sua autoria, a criança se sente igualmente parte do espaço” (pg 50, Apostila RECEI 2010, a reorganização curricular da ed. Infantil municipal de Osasco: concepções para orientar o pensar e o agir docentes – Suely Amaral Mello)"
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  text "\n  ● A participação da criança: A construção de conhecimento implica reconhecer as vivências experienciadas pelas crianças e adolescentes como ponto de partida para ampliar as suas possibilidades de se relacionar com o mundo, transformando-o e sendo transformadas por ele. Desta forma, a participação das crianças no ambiente escolar, além de contribuir para a construção da autonomia, deve ser estimulada pois orientará a ação do educador."

  text "\n  ● O fortalecimento do vínculo escola- família- comunidade: A presença das famílias nas escolas é extremamente positiva para o desenvolvimento das crianças e   adolescentes, na construção de suas identidades, na troca de informações entre familiares e educadores/as sobre suas aprendizagens. Acima de tudo, reconhece-se que todos envolvidos (crianças, adolescentes, familiares e educadores/as) constroem-se nesse movimento ativo de discussão, reflexão e debate."

  text "\n  ● A valorização do brincar: O brincar tem influência fundamental no desenvolvimento da inteligência e personalidade da criança.  Nesta atividade, a criança desenvolve sua atenção, memória, inteligência, e a capacidade de solucionar problemas, imprescindíveis para a aprendizagem. Além disso, a criança exercita a comunicação e o relacionamento com outras crianças, pois precisa combinar a divisão de papéis. "

  text "\n  ● Acesso à herança cultural da humanidade: a escola precisa garantir, em cada atividade, a oportunidade de conhecer a cultura historicamente acumulada, novas aprendizagens e conhecimentos, oferecendo às crianças um ambiente desafiador, agradável, aconchegante, criativo, curioso, repleto de atividades que contem para todos as suas vivências, aquilo que na vida cotidiana ela não tem ou não teve acesso."

  text "Estes temas devem nortear as discussões de todas as dimensões, indicadores de qualidade e questões. este movimento dá continuidade à reflexão sobre a reorientação curricular em desenvolvimento na Rede. Ele também permite voltar o olhar para as ações que precisam ser priorizadas no planejamento de 2011, reforçando a importância da reflexão sobre os temas que estão sendo discutidos  neste momento de avaliação.", :indent_paragraphs => 40

  fill_color "043ccb"
  text "\n 1.5 As unidades educacionais podem comparar sua avaliação com as demais da Rede?", :style => :bold, :size => 14
  fill_color "000000"	
  text "O documento apresenta ainda um quadro que possibilita à unidade educacional  analisar quantitativamente os índices obtidos em 2010 em comparação aos grupos educacionais a que faz parte. no caso das unidades de Creche e Emei, o critério de agrupamento foi regional. No Ensino Fundamental, o critério de agrupamento foi com base no IDEB de 2009 da unidade.", :indent_paragraphs => 40

  text "A sua Unidade Educacional está inserida no seguinte grupo, tendo por base os quadros abaixo:", :indent_paragraphs => 40

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  text "\n"
  text "AGRUPAMENTO DE CRECHES", :align => :center, :size => 16, :style => :bold
  stroke_horizontal_rule
	
  table3 = [["grupo 1","grupo 2","grupo 3","grupo 4"],["Creche Benedita de Oliveira","Creche Elza Batiston","Creche Vilma Catan","Creche Amélia Tozzeto"],["CEMEI Lourdes Candida","Creche Sadamitu Omosako","Creche Maria José da Anunciação","Creche José Espinosa"],["CEMEI Wilma Foltran","Creche Prof. Silvia Ferreira Farhat","Creche Seraphina Bissolati","Creche Alha Elias Abib"],["CMEIEFf Maria José Ferreira Ferraz","CEU Zilda Arns","CEMEIEF Maria Tarsilla","Creche Giuseppa"],["CEMEI Rubens Bandeira","Creche Alzira Silva","Creche Lar da Infância","CEMEI José Ermírio"],["CEMEI João de Farias","Creche Olga Camolesi","Creche Pedro Penov","CEMEI Mário Quintana"],["Creche Prof. Joaquina França","CEMEI Leonil Crê","Creche Moacyr Ayres","Creche Mercedes Correa"], ["CEMEI Fortunato Antiório","Creche Rosa Broseguini","Creche Hilda","Creche Dayse Ribeiro"],["CEMEI Mário Sebastião","CEMEI Mário Sebastião","Creche Rosa Pereira Crê","Creche Sergio Zanardi"],["CEMEIEF Darcy Ribeiro","Creche Ézio Melli","Creche Lídia Thomaz","Cemei Zaira Colino"],["  ","  ","Creche João Correa","Creche Recanto Alegre"],["  ","  ","Creche Ida Belmonte","CEMEI Alberto Santos Dumont"]]
  table table3
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  text "\n"
  text "AGRUPAMENTO DE EMEIs", :align => :center, :size => 16, :style => :bold
  stroke_horizontal_rule

  table3 = [["grupo 1","grupo 2","grupo 3","grupo 4"],["EMEI Maria Bertoni Fiorita","EMEI Maria Alves Dória","EMEI Helena Coutinho","CEMEI Zaíra Collino"],["EMEI Omar Ogeda","EMEI Nair Bellacoza","EMEI Pedro Martino","EMEI Cristine"],["EMEI Japhet Fonte","EMEIEF Valter de Oliveira","EMEI Maria Madalena Freixeda","CEMEI Alberto Santos Dumont"],["CEMEI Lourdes Candida","CEU Zilda Arns","EMEI Alípio Pereira","EMEI Osvaldo Salles"],["CEMEI Wilma Foltran","EMEI Gertrudes de Rossi","EMEI Estevão Brett","EMEI Esmeralda"],["EMEI Osvaldo Gonçalves","CEMEI Leonil Crê","CEMEIEF Maria Tarcilla","EMEIEF Messias"],["EMEI Yolanda Botaro","EMEI Sonia Maria ","EMEI Dalva Mirian","EMEI Emir Macedo"], ["CEMEI Fortunato Antiório","EMEI Maria Ap. Damy","EMEI Fernando Buonaduce","EMEI Descio Mendes"],["CEMEI Mário Sebastião","  ","EMEI Zuleika","EMEI Zuleika"],["CEMEIEF Darcy Ribeiro","  ","EMEI Fortunata","CEMEI José Emírio"],["EMEI Vivaldo","  ","EMEI Elide Alves","CEMEI Mário Quintana"],["CEMEIEF Maria José Ferreira Ferraz","  ","EMEI Adhemar Pereira","EMEI Salvador Sacco"],["CEMEI Rubens Bandeira","  ","EMEIF Etiene"," "],["CEMEI João de Farias"," ","EMEI Providencia dos Anjos"," "],["EMEI José Flávio","  ","EMEI Ignes Collino","  "]]
  table table3

  text "\n"
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  move_down(3)
  text "AGRUPAMENTO DE EMEFs", :align => :center, :size => 16, :style => :bold
  stroke_horizontal_rule

  table3 = [["grupo 1","grupo 2","grupo 3","grupo 4"],["Unidades Educacionais que não atingiram a meta projetada para ela em 2007 e apresentam IDEB inferior ao da rede municipal.","Unidades Educacionais que atingiram ou ultrapassaram a meta projetada para ela em 2007 mas mantiveram o seu IDEB inferior ao da rede municipal.","Unidades Educacionais que não atingiram a meta projetada para ela em 2007 e apresentam IDEB igual ou superior ao da rede municipal.","Unidades Educacionais que atingiram ou ultrapassaram a meta projetada para ela em 2007 e apresentam IDEB igual ou superior ao da rede municipal"]]
  table table3

  fill_color "4e0d0d"

  start_new_page  
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  text "\n 2. RESULTADOS DA AVALIAÇÃO EDUCACIONAL DA SUA UNIDADE", :align => :center, :style => :bold
  fill_color "043ccb"
  text "\n 2.1 DIMENSÃO 1 - AMBIENTE EDUCATIVO", :align => :center, :style => :bold
  fill_color "000000"


  text "O ambiente educativo visa a fornecer indicadores do ambiente que predomina na escola, das relações entre os diversos segmentos, do grau de conhecimento e participação deles na elaboração dos princípios de convivência e no conhecimento que se tem dos direitos das crianças , tendo em vista sua importância como referência às ações educativas para a escola. A escola é um dos espaços de ensino, aprendizagem e vivência de valores. Nela, os indivíduos se socializam, brincam e experimentam a convivência com a diversidade humana. No ambiente educativo, o respeito, a alegria, a amizade e a solidariedade, a disciplina, a negociação, o combate à discriminação e o exercício dos direitos e deveres são práticas que garantem a socialização e a convivência, desenvolvem e fortalecem a noção de cidadania e de igualdade entre todos.", :indent_paragraphs => 40

  text "\n Percepção da UE sobre a Dimensão 1", :style => :bold
      image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d1.png"
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
    (1..ue.count_indicators(1,service_level)).each do |indicator|
    	image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d1i#{indicator}.png" 
    end	
  
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar"


  table ue.dimension_answers_to_table(1,service_level), :header => true do
    row(0).style :size => 9
   end   

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  text "\n Questões problematizadoras da Dimensão 1", :style => :bold
  text " ● O que faz com que o ambiente educativo na nossa escola propicie  vínculos fortes, solidários, afetivos e alegres entre os diversos segmentos? O que precisa ser melhorado?"
  text " ● Como estamos construindo o nosso ambiente para que este seja compreendido como um lugar de encontros de culturas diversas, de inclusão de pessoas diferentes e que trazem consigo conhecimentos e aprendizagens diferentes?"
  text " ● Que ações podem ser previstas em 2011 para melhorar as relações na acolhida das crianças? E no recreio? E na sala de aula? E no momento da alimentação? E no fim do dia? Quais segmentos estarão envolvidos em cada ação de melhorias do ambiente educativo?"

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  fill_color "043ccb"
  text "\n 2.2 DIMENSÃO 2 - AMBIENTE FÍSICO ESCOLAR E MATERIAIS", :align => :center, :style => :bold
  fill_color "000000"

  text "O ambiente físico escolar está diretamente relacionado à qualidade social da educação. Este deve ser atrativo, organizado, limpo, arejado, agradável, com árvores e plantas.  Deve ainda dispor de móveis, equipamentos e materiais didáticos acessíveis, adequados à realidade da escola e que permitam a prestação de serviços de qualidade aos alunos, aos pais e a toda a comunidade escolar.", :indent_paragraphs => 40

  text "\n Percepção da UE sobre a Dimensão 2", :style => :bold
  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d2.png"
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
    (1..ue.count_indicators(2,service_level)).each do |indicator|
        image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d2i#{indicator}.png"
    end


  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar"
  table ue.dimension_answers_to_table(2,service_level), :header => true do
      row(0).style :size => 9
  end   

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  text "\n Questões problematizadoras da dimensão 2:", :style => :bold
  text "Nesta dimensão, itens fundamentais para o ambiente físico escolar serão avaliados de acordo com três referenciais: suficiência: disponibilidade de material, espaço ou equipamento quando deles se necessita; qualidade: adequação do material à prática pedagógica ( esses recursos respondem às necessidades do processo educativo e do envolvimento com a comunidade)? Estão em boas condições de uso, conservação, organização, beleza, entre outros; bom aproveitamento: valorização e uso eficiente  e flexível de tudo o que se possui.", :indent_paragraphs => 40

  text "● O que no espaço físico da nossa escola  faz com que os educandos tenham prazer em nele permanecer?"
  text "● O que fazer para que o nosso espaço  atenda às necessidades do processo educativo que desenvolvemos? Como estamos organizando o nosso espaço físico para que este seja um espaço adequado para  as brincadeiras? O que precisamos fazer para melhorar neste aspecto?"
  text "● Como estamos organizando o nosso espaço físico e os  materiais  para que estes incentivem e motivem  a expressão das crianças?"

  fill_color "043ccb"
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  text "\n 2.3 DIMENSÃO 3 - PLANEJAMENTO INSTITUCIONAL E PRÁTICA PEDAGÓGICA", :align => :center, :style => :bold
  fill_color "000000"
  text "Essa dimensão visa a fornecer indicadores sobre o processo fundamental da escola que é o de fazer com que os educandos aprendam e adquiram o desejo de aprender cada vez mais e com autonomia. Construção de uma proposta pedagógica bem definida e a necessidade de um planejamento com base em conhecimentos sobre o que os educandos já possuem e o que eles precisam e desejam saber são indicadores fundamentais de uma prática pedagógica centrada no desenvolvimento dos educandos.", :indent_paragraphs => 40

  text "\n Percepção da UE sobre a Dimensão 3", :style => :bold
  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d3.png"
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
    (1..ue.count_indicators(3,service_level)).each do |indicator|
        image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d3i#{indicator}.png"
    end

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar"

  table ue.dimension_answers_to_table(3,service_level), :header => true do
      row(0).style :size => 9
   end   
   
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  text "\n Questões problematizadoras da dimensão 3:", :style => :bold
  text "● O que pode ser pensado em nosso PTA 2011 para aumentar o desejo de aprender das  crianças? O que pode ser previsto em nosso PTA 2011 para que as crianças ampliem suas oportunidades de desenvolverem autonomia na busca por conhecimentos?"
  text "● Como demonstramos  o conhecimento que temos  dos  alunos, das suas origens?   Como observamos as suas particularidades?"
  text "● Buscamos conhecer e compreender as diferenças socioculturais entre os  educandos e suas famílias? Os educandos que chegam à escola com  repertórios, crenças, valores diferentes daqueles que predominam no grupo, na maioria dos professores e dos outros educandos são bem acolhidos e  valorizados?"
  text "● Conhecemos as suas dificuldades e incentivamos as potencialidades dos educandos? "
  text "● Que ações desenvolvemos no cotidiano que fazem com que os educandos sejam sujeitos autônomos, cooperativos  e participativos?"
  text "● Como organizamos o momento do recreio? O que precisamos melhorar para que esse momento seja cooperativo e interativo?"

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  fill_color "043ccb"
  text "\n 2.4 DIMENSÃO 4 – AVALIAÇÃO", :align => :center, :style => :bold
  fill_color "000000"

  text "Essa dimensão visa a fornecer os indicadores que dizem respeito à prática da avaliação como parte integrante e fundamental do processo educativo. Monitoramento do processo de aprendizagem, mecanismos e variedades de avaliação, participação dos educandos no processo de avaliação da aprendizagem; auto-avaliação; avaliação dos profissionais e da escola como um todo; discussão e reflexão sobre as avaliações externas implementadas pelo MEC são indicadores fundamentais que apontam se a escola vem construindo a cultura da avaliação, pressuposto fundamental para o desenvolvimento de uma educação de qualidade, que garanta o direito de aprender.", :indent_paragraphs => 40

  text "\n Percepção da UE sobre a Dimensão 4", :style => :bold
  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d4.png"
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
    (1..ue.count_indicators(4,service_level)).each do |indicator|
        image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d4i#{indicator}.png"
    end
 

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar"
#  table9 = [["Resposta","Professores","Gestores","Educandos","Func. de Apoio","Familiares"],["4.1.1","#{answers411['Professores']}","#{answers411['Gestores']}","#{answers411['Educandos']}","#{answers411['Funcionarios']}","#{answers411['Familiares']}"],["4.1.2","#{answers412['Professores']}","#{answers412['Gestores']}","#{answers412['Educandos']}","#{answers412['Funcionarios']}","#{answers412['Familiares']}"],["4.1.3","#{answers413['Professores']}","#{answers413['Gestores']}","#{answers413['Educandos']}","#{answers413['Funcionarios']}","#{answers413['Familiares']}"],["4.1.4","#{answers414['Professores']}","#{answers414['Gestores']}","#{answers414['Educandos']}","#{answers414['Funcionarios']}","#{answers414['Familiares']}"]]
#  table table9

  table ue.dimension_answers_to_table(4,service_level), :header => true do
      row(0).style :size => 9
   end   
   
  start_new_page
  text "\n Questões problematizadoras da dimensão 4", :style => :bold
  text "● Como estamos avaliando a aprendizagem dos educandos? Estamos contribuindo para que o processo de avaliação seja também um processo de aprendizagem? "
  start_new_page 
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  text "\n"
  text "● Quais são as práticas de avaliação que existem na unidade? O que é avaliado? Quem avalia?  Os educandos participam dos processos de avaliação? "
  text "● Como a escola lida com os resultados das avaliações, sejam elas externas ou internas? "
  text "● Os resultados das avaliações são considerados e reorientam as práticas pedagógicas?"
  text "● Que ações podem ser previstas no PTA 2011 para que os alunos monitorem seu próprio processo de aprendizagem? "
  text "● Que mecanismos e variedades de avaliação podem ser previstas com educandos?"
  text "● Que momentos podem ser previstos no PTA 2011 para que cada segmento se reúna para pensar numa auto avaliação das ações previstas para e por seu segmento?"
  text "● Que ações podem ser previstas no PTA 2011 tendo por base as reflexões sobre avaliações externas implementadas pelo MEC?"

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  fill_color "043ccb"
  text "\n 2.5 DIMENSÃO 5 – ACESSO E PERMANÊNCIA DOS EDUCANDOS NA ESCOLA", :align => :center, :style => :bold
  fill_color "000000"

  text "Esta dimensão visa a fornecer indicadores sobre como a escola tem tratado a questão da democratização do acesso do aluno à instituição educativa, das faltas, da evasão e do abandono e dos esforços que a escola vem promovendo para fazer com que os educandos que  evadiram ou abandonaram voltem para a escola. O acesso, ou seja, a matrícula é a porta inicial para a democratização, mas torna-se necessário, também, garantir o direito de todos os que ingressam na Escola as condições de nela permanecer com sucesso (ou seja, permanecer e “aprender” na escola), sem interrupções até o término de um ciclo. Essa dimensão trata ainda, da identificação dos indicadores referentes às necessidades educativas das respectivas comunidades.", :indent_paragraphs => 40

  text "\n Percepção da UE sobre a Dimensão 5", :style => :bold
 image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d5.png"
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
    (1..ue.count_indicators(5,service_level)).each do |indicator|
        image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d5i#{indicator}.png"
    end
 

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
   text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar"
#  table11 = [["Resposta","Professores","Gestores","Educandos","Func. de Apoio","Familiares"],["5.1.2","#{answers512['Professores']}","#{answers512['Gestores']}","#{answers512['Educandos']}","#{answers512['Funcionarios']}","#{answers512['Familiares']}"],["5.2.2","#{answers522['Professores']}","#{answers522['Gestores']}","#{answers522['Educandos']}","#{answers522['Funcionarios']}","#{answers522['Familiares']}"],["5.2.3","#{answers523['Professores']}","#{answers523['Gestores']}","#{answers523['Educandos']}","#{answers523['Funcionarios']}","#{answers523['Familiares']}"],["5.3.1","#{answers531['Professores']}","#{answers531['Gestores']}","#{answers531['Educandos']}","#{answers531['Funcionarios']}","#{answers531['Familiares']}"]]
#  table table11
  table ue.dimension_answers_to_table(5,service_level), :header => true do
    row(0).style :size => 9
   end   
  start_new_page
  text "\n Questões problematizadoras da dimensão 5", :style => :bold
  text "● Há evasão e abandono dos alunos? Estamos conseguindo garantir a permanência dos alunos na escola? O que vêm sendo feito para garantir a permanência? A frequência dos alunos é satisfatória, ou seja, há muita falta por parte dos alunos? O que isso significa? Buscamos conhecer as causas da ausência? Há uma boa comunicação entre a escola e a família para este acompanhamento? Como estamos lidando com a questão da evasão e do abandono escolar? Como estamos lidando com as necessidades educativas da nossa comunidade? O que precisamos fazer para melhorar esses indicadores?"

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  fill_color "043ccb"
  text "\n DIMENSÃO 6 – PROMOÇÃO DA SAÚDE", :align => :center, :style => :bold
  fill_color "000000"
  text "A dimensão Promoção da Saúde se relaciona com os indicadores que dizem respeito as práticas cotidianas e os cuidados que a instituição tem com relação à saúde das crianças e dos adultos da escola. A atenção à saúde das crianças é um aspecto muito importante do trabalho em instituições de educação. As práticas cotidianas precisam assegurar a prevenção de acidentes, os cuidados com a higiene e uma alimentação saudável, para o bom desenvolvimento das crianças em idade de crescimento.", :indent_paragraphs => 40

  text "\n 2.6 Percepção da UE sobre a Dimensão 6", :style => :bold
  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d6.png"
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
    (1..ue.count_indicators(6,service_level)).each do |indicator|
        image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d6i#{indicator}.png"
    end
 

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar"

  table ue.dimension_answers_to_table(6,service_level), :header => true do
    row(0).style :size => 9
   end
      
  start_new_page
  
  text "\n Questões problematizadoras da dimensão 6", :style => :bold
  text "● Como estamos lidando com a questão da saúde entre os segmentos da nossa comunidade?  Qual a compreensão de saúde? Ausência de saúde é quando o corpo está doente? A comunidade e a escola percebem a relação da saúde com as condições sociais, econômicas, culturais, afetivas, emocionais? A escola busca um trabalho integrado com algum equipamento público da área da saúde que esteja no entorno da unidade educacional? A escola procura adotar medidas preventivas para a promoção da saúde? Quais ações estamos desenvolvendo que estejam diretamente relacionadas à promoção da saúde? Quais precisam ser desenvolvidas para que esses dados sejam melhorados?"

  start_new_page

  fill_color "043ccb"
  text "\n\n 2.7 DIMENSÃO 7 - EDUCAÇÃO SOCIOAMBIENTAL E PRÁTICAS ECOPEDAGÓGICAS", :align => :center, :style => :bold
  fill_color "000000"

  text "A dimensão Educação socioambiental e práticas ecopedagógicas visa a fornecer indicadores sobre a formação em torno dos temas da cidadania planetária e as práticas educativas que garantem o conhecimento da realidade e a participação na construção de uma sociedade sustentável, fundamentos da ecopedagogia.", :indent_paragraphs => 40

  text "\n Percepção da UE sobre a Dimensão 7", :style => :bold
  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d7.png"
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
    (1..ue.count_indicators(7,service_level)).each do |indicator|
        image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d7i#{indicator}.png"
    end



  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar"
#  table15 = [["Resposta","Professores","Gestores","Educandos","Func. de Apoio","Familiares"],["7.1.1","#{answers711['Professores']}","#{answers711['Gestores']}","#{answers711['Educandos']}","#{answers711['Funcionarios']}","#{answers711['Familiares']}"],["7.1.2","#{answers712['Professores']}","#{answers712['Gestores']}","#{answers712['Educandos']}","#{answers712['Funcionarios']}","#{answers712['Familiares']}"],["7.1.3","#{answers713['Professores']}","#{answers713['Gestores']}","#{answers713['Educandos']}","#{answers713['Funcionarios']}","#{answers713['Familiares']}"],["7.1.4","#{answers714['Professores']}","#{answers714['Gestores']}","#{answers714['Educandos']}","#{answers714['Funcionarios']}","#{answers714['Familiares']}"],["7.1.5","#{answers715['Professores']}","#{answers715['Gestores']}","#{answers715['Educandos']}","#{answers715['Funcionarios']}","#{answers715['Familiares']}"],["7.2.1","#{answers721['Professores']}","#{answers721['Gestores']}","#{answers721['Educandos']}","#{answers721['Funcionarios']}","#{answers721['Familiares']}"],["7.2.2","#{answers722['Professores']}","#{answers722['Gestores']}","#{answers722['Educandos']}","#{answers722['Funcionarios']}","#{answers722['Familiares']}"],["7.2.3","#{answers723['Professores']}","#{answers723['Gestores']}","#{answers723['Educandos']}","#{answers723['Funcionarios']}","#{answers723['Familiares']}"],["7.2.4","#{answers711['Professores']}","#{answers724['Gestores']}","#{answers724['Educandos']}","#{answers724['Funcionarios']}","#{answers724['Familiares']}"],["7.2.5","#{answers725['Professores']}","#{answers725['Gestores']}","#{answers725['Educandos']}","#{answers725['Funcionarios']}","#{answers725['Familiares']}"]]
#  table table15
  table ue.dimension_answers_to_table(7,service_level), :header => true do
    row(0).style :size => 9
   end   
   
  start_new_page
  text "\n Questões problematizadoras da dimensão 7", :style => :bold
  text "● Como a Unidade Educacional lida com a questão socioambiental? Temos conseguido enraizar uma educação socioambiental e práticas ecopedagógicas mais consistentes entre os segmentos da comunidade escolar? "
  text "● Como a dimensão “eco” do Projeto “ECO”-Político-Pedagógico vem se concretizando na unidade? O que deve ser priorizado para que tenhamos uma conscientização socioambiental ainda maior? E o que deve ser feito para que a consciência seja concretizada em práticas no cotidiano da escola?"
  text "● Que ações cada segmento pode prever no seu PTA 2011 para que haja melhorias em relação a  práticas ecopedagógicas?"

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]

  fill_color "043ccb"
  text "\n DIMENSÃO 8 - ENVOLVIMENTO COM AS FAMÍLIAS E PARTICIPAÇÃO NA REDE DE PROTEÇÃO SOCIAL", :align => :center, :style => :bold
  fill_color "000000"

  text "A dimensão  Envolvimento com as famílias e participação na Rede de Proteção Social visa fornecer os indicadores que apontam se as famílias vêm sendo acolhidas pela Escola e em que medida a Escola vem garantido o direito das famílias acompanharem as vivências e produções das crianças. Essa dimensão visa ainda fornecer os indicadores que apontam em que medida se dá a articulação da Escola com a Rede de Proteção aos Direitos das Crianças, pois a escola é responsável, juntamente com as famílias, por garantir os direitos das crianças. Também visa refletir como os demais serviços públicos de alguma forma estão contribuindo para que todas as crianças sejam, de fato, sujeitos de direitos, conforme preconiza o Estatuto da Criança e do Adolescente (ECA).", :indent_paragraphs => 40

  text "\n 2.8 Percepção da UE sobre a Dimensão 8", :style => :bold
  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d8.png"
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
    (1..ue.count_indicators(8,service_level)).each do |indicator|
        image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d8i#{indicator}.png"
    end
 

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar "
#  table17 = [["Resposta","Professores","Gestores","Educandos","Func. de Apoio","Familiares"],["8.1.1","#{answers811['Professores']}","#{answers811['Gestores']}","#{answers811['Educandos']}","#{answers811['Funcionarios']}","#{answers811['Familiares']}"],["8.1.2","#{answers812['Professores']}","#{answers812['Gestores']}","#{answers812['Educandos']}","#{answers812['Funcionarios']}","#{answers812['Familiares']}"],["8.1.3","#{answers813['Professores']}","#{answers813['Gestores']}","#{answers813['Educandos']}","#{answers813['Funcionarios']}","#{answers813['Familiares']}"],["8.1.4","#{answers814['Professores']}","#{answers814['Gestores']}","#{answers814['Educandos']}","#{answers814['Funcionarios']}","#{answers814['Familiares']}"],["8.1.5","#{answers815['Professores']}","#{answers815['Gestores']}","#{answers815['Educandos']}","#{answers815['Funcionarios']}","#{answers815['Familiares']}"]]
#  table table17
  table ue.dimension_answers_to_table(8,service_level), :header => true do
    row(0).style :size => 9
  end
start_new_page
  text "\n Questões problematizadoras da dimensão 8", :style => :bold
  text "● Quanto maior e mais positiva for a interação entre a escola e os familiares e a comunidade a que ela atende, maior é a probabilidade da escola oferecer aos seus educandos um ensino de qualidade. Diante dessa afirmação, como estamos promovendo a cooperação e o envolvimento com as famílias de nossa comunidade? A nossa escola procura conhecer e trocar experiências com as famílias e com a comunidade?"
  text "● A escola interage com e valoriza o conhecimento das famílias dos alunos? A escola conhece a profissão dos pais e das mães? A escola conhece as habilidades artístico-culturais dos pais e dos alunos? De que forma o conhecimento, os saberes dos pais e dos familiares dialogam com os saberes da escola? Essas habilidades, conhecimentos e saberes são mobilizados para promover uma integração maior entre a escola e as famílias?"
  text "● Como são realizadas as reuniões de pais e familiares? Quem define as pautas, o conteúdo do que vai ser abordado nas reuniões? Os pais e familiares são ouvidos para que suas preocupações também sejam conhecidas e consideradas nas reuniões?"
  text "● A nossa escola favorece vínculos positivos de parceria com os familiares dos educandos? Quais? De que forma eles são percebidos pelos diferentes segmentos e de que forma impactam no aprendizado e interesse e prazer da criança pelos estudos?"
  text "\n ● De que maneira criamos situações para que os familiares e comunidade possam participar do planejamento da escola?"
  text "● A escola busca mapear e identificar o que existe no seu entorno que pode contribuir para a constituição de uma rede de proteção social dos direitos da criança?" 
  text "● Mantemos uma articulação estreita com a Rede de Proteção aos Direitos das crianças e procuramos nos atualizar no tocante à observação dos educandos com possíveis sinais de negligência e violência física e psicológica?"
  text "● Quais procedimentos a escola adota ao constatar sinais de violência e desrespeito à integridade da criança?"

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  fill_color "043ccb"
  text "\n 2.9 DIMENSÃO 9 - GESTÃO ESCOLAR DEMOCRÁTICA", :align => :center, :style => :bold
  fill_color "000000"

  text "A Dimensão Gestão escolar democrática visa fornecer indicadores sobre o grau de participação da comunidade que as escolas vêm conseguindo instituir, como tem se dado a comunicação entre todos, o papel e a atuação dos coletivos escolares e as parcerias e recursos que elas têm conseguido conquistar.", :indent_paragraphs => 40

  text "\n Percepção da UE sobre a Dimensão 9", :style => :bold
  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d9.png"
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
    (1..ue.count_indicators(9,service_level)).each do |indicator|
        image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d9i#{indicator}.png"
    end
 

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar "
 # table19 = [["Resposta","Professores","Gestores","Educandos","Func. de Apoio","Familiares"],["9.1.1","#{answers911['Professores']}","#{answers911['Gestores']}","#{answers911['Educandos']}","#{answers911['Funcionarios']}","#{answers911['Familiares']}"],["9.1.2","#{answers912['Professores']}","#{answers912['Gestores']}","#{answers912['Educandos']}","#{answers912['Funcionarios']}","#{answers912['Familiares']}"],["9.2.1","#{answers921['Professores']}","#{answers921['Gestores']}","#{answers921['Educandos']}","#{answers921['Funcionarios']}","#{answers921['Familiares']}"],["9.2.2","#{answers922['Professores']}","#{answers922['Gestores']}","#{answers922['Educandos']}","#{answers922['Funcionarios']}","#{answers922['Familiares']}"],["9.2.3","#{answers923['Professores']}","#{answers923['Gestores']}","#{answers923['Educandos']}","#{answers923['Funcionarios']}","#{answers923['Familiares']}"],["9.3.1","#{answers931['Professores']}","#{answers931['Gestores']}","#{answers931['Educandos']}","#{answers931['Funcionarios']}","#{answers931['Familiares']}"],["9.3.2","#{answers932['Professores']}","#{answers932['Gestores']}","#{answers932['Educandos']}","#{answers932['Funcionarios']}","#{answers932['Familiares']}"]]
 # table table19
  table ue.dimension_answers_to_table(9,service_level), :header => true do
      row(0).style :size => 9
  end
  
  start_new_page
  text "\n Questões problematizadoras da dimensão 9", :style => :bold
  text "● O que podemos prever, no PTA 2011, para ampliar a participação da comunidade escolar nos órgãos colegiados (Conselho de Gestão Compartilhada, Associação de Pais e Mestres)? "
  text "● Quais as iniciativas que a escola vem tomando para aproximar os pais/familiares e comunidade da unidade educacional?"
  text "\n ● A escola cria um ambiente e uma atmosfera adequada à participação? Como vêm sendo feitas as reuniões dos CGC? Em que horário? Qual o tempo de duração e a periodicidade? Qual a pauta, o conteúdo dessas reuniões? Elas contemplam as preocupações dos pais/familiares e comunidade? Qual a metodologia de realização das reuniões? A forma como a reunião é realizada valoriza a participação dos diferentes segmentos? Que vozes são valorizadas e que vozes são silenciadas? As decisões do CGC são efetivamente encaminhadas? Há um Plano de Trabalho do CGC? Ou a atuação do CGC é para “apagar incêndios”? "
  text "● De que forma os integrantes do CGC participam das avaliações, do PME, da elaboração do PTA, do PEPP?"
  text "● Como estamos lidando com a questão da informação entre os membros de nossa comunidade? Compartilhamos as informações de maneira rápida e precisa com todos os segmentos? Como  informamos e compartilhamos com os nossos educandos e familiares as decisões importantes sobre o funcionamento da escola?"
  text "● Como está  o diálogo com os parceiros da escola? A escola busca, por exemplo, integração com o Orçamento Participativo?  A escola busca integração com outros equipamentos públicos da região?"
  text "● Numa gestão democrática, é preciso saber lidar com os conflitos e opiniões diferentes. Como a escola lida com os conflitos? A escola busca mapear/identificar as insatisfações dos diferentes segmentos e busca construir canais de diálogo para a  construção de soluções/propostas coletivas? Que ações a escola prevê para que haja mais espaços de escuta e de construção coletiva de propostas e encaminhamentos?"

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  fill_color ",43ccb"
  text "\n DIMENSÃO 10 - FORMAÇÃO E CONDIÇÕES DE TRABALHO DOS PROFISSIONAIS DA ESCOLA", :align => :center, :style => :bold
  fill_color "000000"

  text "A dimensão Formação e condições de trabalho dos profissionais da escola visa fornecer indicadores sobre as condições de trabalho implementadas pela escola em relação à formação inicial; à formação continuada; à assiduidade e à estabilidade da equipe que a escola tem conseguido institucionalizar.", :indent_paragraphs => 40

  text "\n 2.9 Percepção da UE sobre a Dimensão 10", :style => :bold
  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d10.png"
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
    (1..ue.count_indicators(10,service_level)).each do |indicator|
        image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d10i#{indicator}.png"
    end
 

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar "
#  table21 = [["Resposta","Professores","Gestores","Educandos","Func. de Apoio","Familiares"],["10.1.1","#{answers1011['Professores']}","#{answers1011['Gestores']}","#{answers1011['Educandos']}","#{answers1011['Funcionarios']}","#{answers1011['Familiares']}"],["10.1.2","#{answers1012['Professores']}","#{answers1012['Gestores']}","#{answers1012['Educandos']}","#{answers1012['Funcionarios']}","#{answers1012['Familiares']}"],["10.2.1","#{answers1021['Professores']}","#{answers1021['Gestores']}","#{answers1021['Educandos']}","#{answers1021['Funcionarios']}","#{answers1021['Familiares']}"],["10.2.2","#{answers1022['Professores']}","#{answers1022['Gestores']}","#{answers1022['Educandos']}","#{answers1022['Funcionarios']}","#{answers1022['Familiares']}"],["10.2.3","#{answers1023['Professores']}","#{answers1023['Gestores']}","#{answers1023['Educandos']}","#{answers1023['Funcionarios']}","#{answers1023['Familiares']}"],["10.3.1","#{answers1031['Professores']}","#{answers1031['Gestores']}","#{answers1031['Educandos']}","#{answers1031['Funcionarios']}","#{answers1031['Familiares']}"],["10.3.2","#{answers1032['Professores']}","#{answers1032['Gestores']}","#{answers1032['Educandos']}","#{answers1032['Funcionarios']}","#{answers1032['Familiares']}"],["10.4.1","#{answers1041['Professores']}","#{answers1041['Gestores']}","#{answers1041['Educandos']}","#{answers1041['Funcionarios']}","#{answers1041['Familiares']}"],["10.4.2","#{answers1042['Professores']}","#{answers1042['Gestores']}","#{answers1042['Educandos']}","#{answers1042['Funcionarios']}","#{answers1042['Familiares']}"],["10.5.1","#{answers1051['Professores']}","#{answers1051['Gestores']}","#{answers1051['Educandos']}","#{answers1051['Funcionarios']}","#{answers1051['Familiares']}"]]

#  table table21
  table ue.dimension_answers_to_table(10,service_level), :header => true do
      row(0).style :size => 9
   end   
   
  start_new_page
  text "\n Questões problematizadoras da dimensão 10", :style => :bold
  text "● Que ações a unidade pode prever no PTA 2011 para contemplar as demandas de formação continuada de cada segmento de profissionais da escola? Quais assuntos serão abordados com cada segmento? Quais momentos de formação continuada a unidade pode organizar para cada segmento de profissionais da escola?"
  text "● A escola busca identificar as dificuldades, os desafios, as propostas dos funcionários para melhorar a formação e as condições de trabalho? "
  text "● A escola busca construir uma atmosfera e uma ambiente favorável à integração, ao trabalho coletivo e solidário? De que forma?"
  text "● O que pode ser previsto por e para cada segmento no PTA 2011 da sua unidade para melhorar as condições de trabalho de todos profissionais da escola?"
  text "● Como a nossa escola promove a responsabilidade e o comprometimento dos professores e demais funcionários com o trabalho que realizam na Escola?"
  text "● A escola promove uma autoavaliação dos professores? De que forma? E como a autoavaliação interfere no aperfeiçoamento do trabalho?"
  text "● Como motivamos os nossos  professores e demais funcionários para  o trabalho que realizam?"
  text "● De que forma a escola tem se apropriado das Paradas Pedagógicas, das Conferências Municipais, dos Seminários de Práticas, dos Cursos e Oficinas, dos Encontros Internacionais de Educação e de outras iniciativas de formação da política educacional para a valorização e formação dos profissionais?"
  text "● Como a escola pode se preparar para melhor aproveitar cada um desses importantes espaços de formação?"

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  fill_color "043ccb"
  text "\n 2.11 DIMENSÃO 11 - PROCESSOS DE ALFABETIZAÇÃO E LETRAMENTO (Apenas para o Ensino Fundamental)", :align => :center, :style => :bold
  fill_color "000000"

  text "Essa dimensão diz respeito aos indicadores referentes a todos os aspectos que, no conjunto, favorecem a alfabetização inicial e a ampliação da capacidade da leitura e escrita de todas as crianças e adolescentes ao longo do ensino fundamental.  O domínio da leitura e da escrita é condição para o bom desenvolvimento de outros conteúdos escolares e, também, para que, depois de concluída a educação básica, o cidadão e cidadã possam continuar aprendendo e se desenvolvendo com autonomia.", :indent_paragraphs => 40

  text "\n Percepção da UE sobre a Dimensão 11", :style => :bold
  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d11.png"
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
    (1..ue.count_indicators(11,service_level)).each do |indicator|
        image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d11i#{indicator}.png"
    end

   
  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar "
#  table23 = [["Resposta","Professores","Gestores","Educandos","Func. de Apoio","Familiares"],["11.1.1","#{answers1111['Professores']}","#{answers1111['Gestores']}","#{answers1111['Educandos']}","#{answers1111['Funcionarios']}","#{answers1111['Familiares']}"],["11.1.2","#{answers1112['Professores']}","#{answers1112['Gestores']}","#{answers1112['Educandos']}","#{answers1112['Funcionarios']}","#{answers1112['Familiares']}"],["11.2.1","#{answers1121['Professores']}","#{answers1121['Gestores']}","#{answers1121['Educandos']}","#{answers1121['Funcionarios']}","#{answers1121['Familiares']}"],["11.2.2","#{answers1122['Professores']}","#{answers1122['Gestores']}","#{answers1122['Educandos']}","#{answers1122['Funcionarios']}","#{answers1122['Familiares']}"],["11.2.3","#{answers1123['Professores']}","#{answers1123['Gestores']}","#{answers1123['Educandos']}","#{answers1123['Funcionarios']}","#{answers1123['Familiares']}"]]
#  table table23
  table ue.dimension_answers_to_table(11,service_level), :header => true do
      row(0).style :size => 9
   end   
   
  start_new_page
  text "\n Questões problematizadoras da dimensão 11", :style => :bold
  text "● Que ações podem ser previstas para que em 2011 outros segmentos da escola se envolvam no exercício da função social da escrita pela criança? "
  text "● Que propostas podemos planejar para que em 2011 haja atividades lúdicas nas quais a criança exercite a expressão de suas produções e registros (abordando diversas esferas de circulação, práticas de linguagem, contextos e gêneros)? Que propostas podem ser previstas para que a criança socialize com diferentes segmentos as suas produções e registros?"
  text "● Que outras ações podem ser previstas no PTA 2011 para que nossos educandos, familiares e demais membros da comunidade  desenvolvam o  prazer pela leitura e pela escrita?"
  text "● Que ações os diferentes segmentos podem prever para que haja maior circulação dos livros da escola entre alunos, familiares e membros da comunidade?"
  text "● Que ações podem ser previstas no PTA 2011 para que diversos tipos de linguagens artísticas sejam abordados pela unidade em sua biblioteca/sala de leitura com diferentes segmentos?"
  text "● Que ações podem ser previstas no PTA 2011 para que os educandos e membros da comunidade tenham acesso e possam emprestar os livros e demais textos disponíveis na escola?"

  fill_color "4e0d0d"
  start_new_page  
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  text "\n\n 4 QUADRO DE ÍNDICES DA SUA UNIDADE EDUCACIONAL EM COMPARAÇÃO COM A REDE", :style => :bold
  fill_color "000000"
  text "A sua Unidade Educacional pode ainda analisar o ano letivo de 2010 a partir do quadro comparativo de índices obtidos pelas unidades educacionais da Rede. Mas antes é preciso lembrar alguns pontos:", :indent_paragraphs => 40
  text "A) Os participantes de cada segmento escolheram uma opinião numérica que expressou sua percepção em relação à unidade educacional;"
  text "B) A síntese numérica de cada segmento foi gerada calculando as médias das opiniões de cada segmento;"
  text "C) As médias dos indicadores e das dimensões foram calculadas a partir das médias das respostas dos segmentos em cada questão;"
  text "D) O número máximo, que expressava a melhor situação em cada resposta era 5;"

  text "\n Com  base nessas premissas foi estabelecido um índice para cada U.E, em cada dimensão, utilizando a seguinte metodologia: "
  text "● A soma das respostas dadas pelos segmentos, dividida pela máxima pontuação que a unidade educacional poderia atribuir a si mesma, dentro de cada dimensão. Por exemplo: numa determinada dimensão, 8 pessoas expressaram sua opinião numérica para as 10 questões contidas nela. Se 5 era a máxima opinião numérica que se podia dar,  para essa dimensão a máxima pontuação que a UE poderia receber é: 400, ou seja: 8 vezes 10, que é igual a 80, vezes 5, que é igual a 400. Contudo, a soma obtida pela UE, a partir da opinião dessas oito pessoas a essas 10 questões foi de 240. O índice obtido pela UE, nessa dimensão é obtida dividindo 240 por 400, ou seja: 0,6. Quanto mais próximo do 1,0 melhor o índice obtido pela unidade."
  text "● Ao propor um índice de análise para a sua unidade educacional, busca-se construir alternativas que permitam à comunidade escolar avaliar o seu êxito, comparando o atual ano letivo com os anteriores, além de perceber-se em relação às demais unidades que integram a Rede de Osasco, sem jamais pretender o estabelecimento de ranking entre as escolas. Considerando as complexidades típicas de uma rede pública de ensino, a construção de índices e sínteses numéricas associadas a conjuntos de indicadores de qualidade, definidos não arbitrariamente mas democraticamente, favorecem uma melhor gestão das suas demandas e necessidades."
  text "\n Diante do quadro a seguir, é importante que a comunidade escolar reflita: em quais dimensões a unidade educacional apresentou melhor desempenho? Quais merecem maior atenção durante a construção do seu Plano de Trabalho Anual de 2011?"

 start_new_page 
 number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  fill_color "043ccb"
  text "\n Quadro dos índices da unidade, por dimensões e por segmentos", :style => :bold, :align => :center
  fill_color "0000000"
  
  text "O índice geral da sua Unidade em 2010, obtido com base na média dos índices de cada dimensão é: "
  
  move_down(10)
  header_table = ["1. Ambiente Educativo","2 Ambiente Físico Escolar e Materiais","3 Avaliação","4 Planejamento Institucional e Prática Pedagógica","5 Acesso e Permanência dos Educandos na Escola","6 Promoção da Saúde","7 Educação Socioambiental e Práticas Ecopedagógicas","8 Envolvimento com as Famílias e Participação na Rede de Proteção Social","9 Gestão Escolar Democrática","10. Formação e Condições de Trabalho dos Profissionais da Escola","11. Processos de Alfabetização e Letramento (Somente para as EMEFs)"]
  table  ue.grade_to_table(service_level,header_table) do
      row(0).style :size => 7
   end   

  start_new_page
  number_pages "<page>",[(bounds.left + bounds.right)/2, 0]
  fill_color "4e0d0d"
  text "\n 5 ENCAMINHAMENTOS PARA O PLANO DE TRABALHO ANUAL DE 2011", :style => :bold, :align => :center
  fill_color "000000"

 table26 = [["Nome da Unidade Educacional:                                                                                                                   "],["Nome da Dimensão:                                                "],["Nome dos envolvidos:\n\n\n\n\n\n\n                                                "]]
 table table26

  text "\n"

  table27 = [["Práticas Consolidadas","Práticas que precisam avançar"],["                                                  \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n","                                                                                                                      "]]
  table table27


end
end
end
