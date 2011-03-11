require "open-uri"
require "rubygems"
require "prawn"
require "prawn/layout"

class GeneralReport

  def self.get_group_data(type)
    hash = {:group_1 => {}, :group_2 => {}, :group_3 => {}, :group_4 => {},}
    if type == "infantil"
      Dimension.infantil.each do |dimension|
        dimension_values = []
        ServiceLevel.infantil.each do |service_level|
          dimension_values << calc_media_by_group_and_service_level(dimension, service_level)
        end
        group_1_value = (dimension_values[0][0] + dimension_values[1][0])/2
        group_2_value = (dimension_values[0][1] + dimension_values[1][1])/2
        group_3_value = (dimension_values[0][2] + dimension_values[1][2])/2
        group_4_value = (dimension_values[0][3] + dimension_values[1][3])/2
        hash[:group_1][dimension.number] = group_1_value
        hash[:group_2][dimension.number] = group_2_value
        hash[:group_3][dimension.number] = group_3_value
        hash[:group_4][dimension.number] = group_4_value
      end
  else
      Dimension.fundamental.each do |dimension|
        dimension_values = calc_media_by_group_and_service_level(dimension, ServiceLevel.fundamental.first)
        hash[:group_1][dimension.number] = dimension_values[0]
        hash[:group_2][dimension.number] = dimension_values[1]
        hash[:group_3][dimension.number] = dimension_values[2]
        hash[:group_4][dimension.number] = dimension_values[3]
      end
    end
    hash
  end

  def self.to_pdf
    margin = [30, 30, 30, 30]
    Prawn::Document.generate("#{RAILS_ROOT}/public/relatorios/geral.pdf",
      :margin => margin, :template => "#{RAILS_ROOT}/public/relatorios/artifacts/capa_avaliação.pdf") do

      def insert_graphics(graphics_numbers, type)
        i = 0
        vpositions = [20, 250]
        vposition_control = 0
        graphics_numbers.each do |number|
          i += 1
          if( i%2 == 0)
            image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/#{type}/general_average_dimensioni#{number}-graph.jpg", :scale => 0.59, :position => 260, :vposition => vpositions[vposition_control]
            vposition_control += 1
          else
            image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/#{type}/general_average_dimensioni#{number}-graph.jpg", :scale => 0.59, :position => 0, :vposition => vpositions[vposition_control]
          end
          if vposition_control == 2
            vposition_control = 0
            start_new_page if number != graphics_numbers.last
          end
        end
      end

      def number_pages(string, position)
        page_count.times do |i|
          unless(i < 3)
           go_to_page(i)
           str = string.gsub("<page>","#{i}").gsub("<total>","#{page_count}")
           draw_text str, :at => position, :size => 14, :style => :italic
          end
        end
      end

      def get_total_number_of_people_that_answered_the_surveys
        result = ActiveRecord::Base.connection.execute(
          "
          SELECT sum(participants), seg.name FROM
            (SELECT user_id,survey_id, MAX(participants_number) AS participants FROM answers
            GROUP BY user_id, survey_id) a
          INNER JOIN surveys s ON s.id = a.survey_id
          INNER JOIN segments seg ON seg.id = s.segment_id
          GROUP BY seg.id
          ")
        hash = {}
        result.each do |r|
          hash[r[1]] = r[0]
        end
        hash
      end

      def show_table_with_index_by_unit
        table12 =[["Índice           ","Situação das unidades de acordo com os resultados obtidos"],
          ["0 – 0,33","Unidades que necessitam ser priorizadas nas intervenções relacionadas com a dimensão"],
          ["0,34 – 0,66","Unidades que ainda necessitam de intervenções, mas que já apresentam avanços relacionados a essa dimensão"],
          ["0,67 - 1","Unidades com ações já desenvolvidas com relação à dimensão"]]

        table table12 do
          cells[1,0].background_color = "ff0000"
          cells[2,0].background_color = "ffff00"
          cells[3,0].background_color = "008000"
        end
      end

      # font
      font_families.update(
        "pt sans" => {:normal => "#{RAILS_ROOT}/public/fonts/PT_Sans-Regular.ttf",
                      :bold => "#{RAILS_ROOT}/public/fonts/PT_Sans-Bold.ttf",
                      :italic => "#{RAILS_ROOT}/public/fonts/PT_Sans-Italic.ttf",
                      :bolditalic => "#{RAILS_ROOT}/public/fonts/PT_Sans-BoldItalic.ttf"
                      })
      font "pt sans"

      # inicio do texto
      start_new_page(:template => "#{RAILS_ROOT}/public/relatorios/artifacts/expediente.pdf", :template_page => 1)
      start_new_page
      text "\n Relatório Geral da Avaliação Educacional de Osasco de 2010", :align => :center, :size => 16, :style => :bold
      text "\n Sumário", :align => :center, :size => 13
      text "\n APRESENTAÇÃO", :style => :bold, :size => 14
      text "Apresentando o Programa Escola Cidadã e Inclusiva
        Apresentando o Processo de Avaliação e seu Histórico
        Linha do Tempo", :indent_paragraphs => 20

      start_new_page

      text "CAPÍTULO I – QUEM SOMOS ", :style => :bold
      text "1. Apresentando o lugar e os sujeitos protagonistas", :indent_paragraphs => 20
      text "1.1. O município
        1.2. As Unidades Educacionais
        1.3. A composição da Rede
        1.4. A Supervisão de Ensino
        1.5. O Corpo Técnico Pedagógico (CTP)", :indent_paragraphs => 30

      start_new_page

      text "CAPÍTULO II. METODOLOGIA", :style => :bold
      text "2.1. Foco da Avaliação
        2.2. Dimensões e Indicadores de Avaliação
        2.3. Instrumentos
        2.4. Definição de Amostragem
        2.5. Estratégias de Coleta de Dados
        2.6. Análise e Interpretação dos Dados", :indent_paragraphs => 30
      text "2.6.1. Análise estatística e descritiva dos dados da rede de ensino por nível de atendimento
        2.6.2. Organização, sistematização e análise de conteúdo de dados qualitativos
        2.6.3. Análise dos resultados das dimensões por agrupamentos, segundo estratos do IDEB,", :indent_paragraphs => 40
      text " no caso do Ensino Fundamental
        2.6.4. Análise dos resultados das dimensões por agrupamentos regionais, no caso da Educação
        Infantil", :indent_paragraphs => 40
      text "2.6.5. Análise dos índices das unidades escolares por dimensão
        2.6.6. Reflexão e aprendizagem compartilhada", :indent_paragraphs => 40

      start_new_page

      text "CAPÍTULO III. RESULTADOS DA AVALIAÇÃO DO PEC- OSASCO 2010 - EDUCAÇÃO INFANTIL", :style => :bold
      text "3. Análise dos resultados da Educação Infantil", :style => :bold, :indent_paragraphs => 20
      text "3.1. Análise dos dados, por dimensões e indicadores", :style => :bold, :indent_paragraphs => 30
      text "3.1.1. Dimensão 1. Ambiente Educativo", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
        b) gráficos gerais das percepções da rede sobre os indicadores
        c) questões problematizadoras", :indent_paragraphs => 50

      text "3.1.2. Dimensão 2. Ambiente Físico Escolar e Materiais", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
          b) gráficos gerais das percepções da rede sobre os indicadores
          c) questões problematizadoras", :indent_paragraphs => 50

      text "3.1.3. Dimensão 3. Planejamento Institucional e Prática Pedagógica", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
          b) gráficos gerais das percepções da rede sobre os indicadores
          c) questões problematizadoras", :indent_paragraphs => 50

      text "3.1.4. Dimensão 4. Avaliação", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
          b) gráficos gerais das percepções da rede sobre os indicadores
          c) questões problematizadoras", :indent_paragraphs => 50

      text "3.1.5. Dimensão 5. Acesso e Permanência dos Educandos na Escola", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
          b) gráficos gerais das percepções da rede sobre os indicadores
          c) questões problematizadoras", :indent_paragraphs => 50

      text "3.1.6 Dimensão 6. Promoção da Saúde", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
          b) gráficos gerais das percepções da rede sobre os indicadores
          c) questões problematizadoras", :indent_paragraphs => 50

      text "3.1.7. Dimensão 7. Educação Socioambiental e Práticas Ecopedagógicas", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
          b) gráficos gerais das percepções da rede sobre os indicadores
          c) questões problematizadoras", :indent_paragraphs => 50

      text "3.1.8 Dimensão 8. Envolvimento com as Famílias e Participação na Rede de Proteção Social", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
          b) gráficos gerais das percepções da rede sobre os indicadores
          c) questões problematizadoras", :indent_paragraphs => 50

      text "3.1.9. Dimensão 9. Gestão Escolar Democrática", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
          b) gráficos gerais das percepções da rede sobre os indicadores
          c) questões problematizadoras", :indent_paragraphs => 50

      text "3.1.10. Dimensão 10. Formação e Condições de Trabalho dos Profissionais da Escola", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
          b) gráficos gerais das percepções da rede sobre os indicadores
          c) questões problematizadoras", :indent_paragraphs => 50

      text "3.2. Quadro dos índices das unidades por dimensões: Educação Infantil
        3.3. Resultados dos agrupamentos a partir das regiões geográficas, por dimensões: Educação", :style => :bold, :indent_paragraphs => 30
      text "Infantil", :style => :bold, :indent_paragraphs => 30

      start_new_page

      text "CAPÍTULO IV. RESULTADOS DA AVALIAÇÃO DO PEC- OSASCO 2010 - EDUCAÇÃO FUNDAMENTAL", :style => :bold
      text "4. Análise dos resultados do Ensino Fundamental", :style => :bold, :indent_paragraphs => 20
      text "4.1. Análise dos dados por dimensões e indicadores", :style => :bold, :indent_paragraphs => 30

      text "4.1.1. Dimensão 1. Ambiente Educativo", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
        b) gráficos gerais das percepções da rede sobre os indicadores
        c) questões problematizadoras", :indent_paragraphs => 50

      text "4.1.2. Dimensão 2. Ambiente Físico Escolar e Materiais", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
        b) gráficos gerais das percepções da rede sobre os indicadores
        c) questões problematizadoras", :indent_paragraphs => 50

      text "4.1.3. Dimensão 3. Planejamento Institucional e Prática Pedagógica", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
        b) gráficos gerais das percepções da rede sobre os indicadores
        c) questões problematizadoras", :indent_paragraphs => 50

      text "4.1.4. Dimensão 4. Avaliação", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
        b) gráficos gerais das percepções da rede sobre os indicadores
        c) questões problematizadoras", :indent_paragraphs => 50

      text "4.1.5. Dimensão 5. Acesso e Permanência dos Educandos na Escola", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
        b) gráficos gerais das percepções da rede sobre os indicadores
        c) questões problematizadoras", :indent_paragraphs => 50

      text "4.1.6. Dimensão 6. Promoção da Saúde", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
        b) gráficos gerais das percepções da rede sobre os indicadores
        c) questões problematizadoras", :indent_paragraphs => 50

      text "4.1.7. Dimensão 7. Educação Socioambiental e Práticas Ecopedagógicas", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
        b) gráficos gerais das percepções da rede sobre os indicadores
        c) questões problematizadoras", :indent_paragraphs => 50

      text "4.1.8. Dimensão  8. Envolvimento com as Famílias e Participação na Rede de Proteção Social", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
        b) gráficos gerais das percepções da rede sobre os indicadores
        c) questões problematizadoras", :indent_paragraphs => 50

      text "4.1.9. Dimensão 9. Gestão Escolar Democrática", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
        b) gráficos gerais das percepções da rede sobre os indicadores
        c) questões problematizadoras", :indent_paragraphs => 50

      text "4.1.10. Dimensão 10. Formação e Condições de Trabalho dos Profissionais da Escola", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
        b) gráficos gerais das percepções da rede sobre os indicadores
        c) questões problematizadoras", :indent_paragraphs => 50

      text "4.1.11. Dimensão 11. Processos de Alfabetização e Letramento", :indent_paragraphs => 40
      text "a) gráfico geral da rede sobre a dimensão
        b) gráficos gerais das percepções da rede sobre os indicadores
        c) questões problematizadoras", :indent_paragraphs => 50

      text "4.2. Quadro dos índices das unidades de Ensino Fundamental
        4.3. Resultados dos agrupamentos a partir das notas obtidas no IDEB, por dimensões: Ensino ", :style => :bold, :indent_paragraphs => 30
      text "Fundamental", :style => :bold, :indent_paragraphs => 30

      start_new_page

      text "CAPÍTULO V. META-AVALIAÇÃO", :style => :bold, :indent_paragraphs => 20
      text "a) Mobilização
        b) Participação
        c) Metodologia
        d) Condições Físicas e Materiais
        e) Período de Aplicação e Inserção dos dados no on-line
        f) Análise Coletiva", :indent_paragraphs => 30

      start_new_page

      text "CAPÍTULO VI. CONSIDERAÇÕES FINAIS", :style => :bold, :indent_paragraphs => 20

      start_new_page
      text "APRESENTAÇÃO

        Apresentando o Programa Escola Cidadã e Inclusiva", :style => :bold

      text "O Programa Escola Cidadã e Inclusiva de Osasco vem sendo desenvolvido desde 2006 como política pública de educação. Este programa é formado por eixos de trabalho, cujo objetivo é desenvolver ações articuladas – desenvolvimento sustentável, democracia e inclusão social – criando meios para concretizar as diretrizes da política educacional do município: democratização do acesso e garantia da permanência dos educandos nas escolas, gestão democrática, qualidade social da educação e valorização dos profissionais da educação.", :indent_paragraphs => 30
      text "Os marcos referenciais e legais que têm pautado a garantia de direitos de cidadãos e cidadãs de nosso país, tais como a Constituição Federal, a Lei de Diretrizes e Bases (LDB – 9394/96), a Lei 10. 639/03, que altera a LDB 9394/1996 ao incluir o Ensino de História e Cultura Afro-Brasileira e Africana nas escolas brasileiras, a Lei 11645/08, que dá a mesma orientação quanto à temática indígena, a Lei 11.274/06, que amplia o Ensino Fundamental para 9 anos (1º ao 9º ano) e estabelece a entrada da criança de 6 anos no ensino obrigatório, a Política Nacional de Educação em Direitos Humanos, a Política Nacional de Educação Especial na Perspectiva da Educação Inclusiva, o Estatuto da Criança e do Adolescente, a Carta da Terra, dentre outros, são assumidos como pressupostos orientadores do Projeto Eco-Político-Pedagógico, do Plano de Trabalho Anual, das práticas pedagógicas e das relações humanas que se busca estabelecer nas unidades escolares. A vivência de tais processos exige abertura para o trabalho coletivo e participativo, que tem revelado à Rede Municipal de Osasco um modo próprio de construir uma Educação em Direitos Humanos, uma Educação Inclusiva e uma Educação das Relações Etnicorraciais.", :indent_paragraphs => 30

      text "Elencamos os eixos do Programa Escola Cidadã e Inclusiva de Osasco:
          • Projeto Eco-Político-Pedagógico (PEPP) e Plano de Trabalho Anual (PTA)
          • Gestão Democrática
          • Sementes de Primavera: Exercício da Cidadania desde a Infância
          • Promoção dos Direitos da Criança e do Adolescente
          • Reorientação Curricular da Educação Infantil (RECEI)
          • Reorientação Curricular do Ensino Fundamental (RECEF)
          • Movimento de Alfabetização de Jovens e Adultos (MOVA) e Educação de Jovens e Adultos (EJA)
          • Programa de Educação para a Cidadania Planetária (PECP)
          • Programa de Educação Inclusiva (PEI)
          • Salas de Apoio Pedagógico (SAP) e Serviço de Atendimento Educacional Especializado (SAEE)
          • Cursos e Oficinas
          • Conferências Municipais de Educação
          • Formação continuada de gestores, professores, funcionários e Corpo Técnico Pedagógico
          • Programa de Apoio e Aperfeiçoamento dos Profissionais da Educação de Osasco (PAAPE)
          • Fórum Permanente de Educação e Plano Municipal de Educação
          • Avaliação Dialógica", :indent_paragraphs => 30

      text "A Escola Cidadã vislumbrada pelo município de Osasco tem uma perspectiva emancipadora, inspirada no pensamento de Paulo Freire. Educar na perspectiva emancipadora é tornar o educando sujeito. A autonomia (<i>auto-nomos</i>) tem o sentido de autoria, de autorizar-se a ser e a exercer poder. Isso significa que o cotidiano escolar emancipador supera a tradicional modelagem dos alunos à imagem e semelhança das crenças e valores de seus educadores, para promover processo de autoconstrução, orientado por referenciais psicológicos, pedagógicos e sociais.", :indent_paragraphs => 30, :inline_format => true
      text "O município de Osasco adota o conceito de escola cidadã como estratégia para concretizar a gestão democrática da educação e a autonomia dos sistemas de ensino e das escolas, como também promover o desenvolvimento integral do educando para o exercício pleno da cidadania.", :indent_paragraphs => 30
      text "Autonomia e exercício de cidadania, conceitos indissociáveis, somente são realizáveis por sujeitos autônomos. Ser sujeito e ser cidadão são condições relacionais: não há sujeito nem exercício de cidadania sem o outro, e por isso o sujeito cidadão é uma consciência no coletivo, articulada com o outro. A sociedade que temos, e a que queremos ter, é, e sempre será, inexoravelmente, uma construção humana, realizada no e pelo coletivo.", :indent_paragraphs => 30

      text "\n Apresentando o Processo de Avaliação e seu Histórico", :style => :bold
      text "A avaliação de políticas e programas sociais ou educacionais é sempre uma tarefa complexa, pois lida com sujeitos sociais, interesses, representações e contextos concretos. Dessa forma, os programas apresentam um conjunto de variáveis intervenientes que uma única estratégia de avaliação não tem condições de tratar com profundidade. Nesse sentido, existem múltiplas alternativas para avaliar um programa ou uma política. A escolha de uma abordagem avaliativa é resultado de um processo de negociação interativa entre o/a avaliador/a e os principais interessados na avaliação. Pode ser um processo difícil, porque decidir o que vai ser avaliado significa, muitas vezes, decidir o que vai ser excluído do processo avaliativo. Diferentes tipos de avaliações respondem a perguntas diferentes e focalizam questões e variáveis diferentes.", :indent_paragraphs => 30
      text "Considerando que já existe um processo de avaliação formativa, que vem ocorrendo desde o ano de 2006 para as diversas ações desenvolvidas pelo PEC-Osasco, e as perguntas avaliatórias levantadas nessa etapa do programa e as necessidades atuais de conhecimento dos principais interessados no processo de avaliação da Política Educacional de Osasco – Escola Cidadã de Osasco, a presente avaliação se configura com uma abordagem qualitativa, formativa e por triangulação de métodos.", :indent_paragraphs => 30
      text "Cada abordagem guarda especificidades que não podem ser apropriadas de forma linear para os diferentes processos avaliativos. Dada a complexidade do Programa, no presente processo de avaliação foram utilizadas técnicas quantitativas e qualitativas para a coleta e a análise dos dados. A combinação e a utilização desses instrumentos contribuíram para ampliar a visão do objeto avaliado, trazendo complementos importantes para a construção da imagem do PEC a ser conhecido pelos interessados.", :indent_paragraphs => 30
      text "Trata-se de um programa cuja concepção pedagógica se norteia por uma perspectiva participativa e emancipatória, que reconhece o legítimo direito e a capacidade dos envolvidos em contribuírem para o conhecimento da realidade na qual a Política está sendo desenvolvida, como também de se engajarem na mudança social. Nesse sentido, em todas as etapas dessa avaliação, procurou-se o envolvimento e o comprometimento dos diversos segmentos da comunidade escolar, a fim de garantir, na medida do possível, oportunidades de vivências problematizadoras, colaborativas e cooperativas, com o intuito de produzir conhecimentos relevantes, como também sedimentar uma prática de avaliação transformadora e emancipatória.", :indent_paragraphs => 30
      text "\n Linha do Tempo", :style => :bold

      text "
        • <b>agosto 2006:</b> lançamento do Programa Escola Cidadã de Osasco.
        • <b>2º semestre de 2007:</b> formação do 1º GT de Avaliação composto por profissionais do IPF e representantes da educação municipal de Osasco. O GT realizou 18 encontros nos quais se definiram e foram elaborados os passos metodológicos e instrumentais da avaliação.
        • <b>setembro de 2008:</b> pesquisa avaliativa com 846 pessoas de diversos segmentos da comunidade escolar e Secretaria da Educação de Osasco. Pesquisa qualitativa processual, tendo como foco o processo de implantação das principais ações e projetos que constituem o Programa Escola Cidadã de Osasco.
        • <b>fevereiro de 2009:</b> divulgação do Relatório de Avaliação do PEC 2006-2008, baseado na análise dos relatórios do Processo de Leitura do Mundo, Avaliação dos planos de Trabalho Anual (PTA), relatório de atividades do PEC (2007) e pesquisa realizada em setembro de 2008.", :indent_paragraphs => 30, :inline_format => true
      text "
        • <b>2º semestre de 2009:</b> definição do objetivo da avaliação 2009: verificar a efetividade das quatro diretrizes da política educacional na Rede Municipal de Ensino: Democratização do acesso e garantia de permanência; Democratização da gestão; Qualidade social da educação; Valorização dos trabalhadores da educação.
        • <b>final de 2009:</b> aplicação dos instrumentais de avaliação separadamente, por nível de ensino e segmento. Os grupos consensualizaram uma nota para cada questão proposta e foram divididos da seguinte forma:", :indent_paragraphs => 30, :inline_format => true

      table1 =  [[" ", "Segmento de participantes", "Total de questionários"],["Educação Infantil","Familiares e Trabalhadores","2"],["Ensino Fundamental","Familiares, Alunos e Trabalhadores","2"],["EJA","Alunos e Trabalhadores","1"]]
      table table1

      text " \n
        • <b>fevereiro de 2010:</b> Relatório de Avaliação do PEC Osasco 2009 divulgação dos resultados da avaliação 2009 que envolveu a participação de 6.765 pessoas. Desse total 41% foi de professores, 18% de funcionários de apoio, 26% de familiares, 11% de educandos e 4% de segmentos não identificados.
        • <b>2º semestre de 2010:</b> início da construção do processo avaliativo de 2010 cujo objetivo foi avaliar os resultados e impactos do programa a partir das representações e percepções dos diferentes segmentos da comunidade escolar e identificar aspectos que precisam ser priorizados na política educacional.
        • <b>2º semestre de 2010:</b> construção e validação conjunta do instrumental de Avaliação de 2010, elaborado com a participação dos membros do GT de avaliação do IPF e Corpo Técnico da rede de Osasco.
        • <b>novembro e dezembro de 2010:</b> aplicação dos instrumentais de avaliação separadamente, por nível de ensino ( Educação  Infantil e Ensino Fundamental) e segmento (educandos, familiares, funcionários, professores e gestores). Apesar da discussão coletiva, cada participante atribuiu uma síntese numérica individualmente às questões propostas, que foi somada aos outros grupos do mesmo segmento, gerando posteriormente um cálculo de média do segmento.
        • <b>dezembro de 2010:</b> inserção das sínteses numéricas diretamente no sistema online dos dados oriundos da pesquisa avaliativa com os diversos segmentos.", :indent_paragraphs => 30, :inline_format => true

      start_new_page
      text "\n CAPÍTULO I – QUEM SOMOS", :style => :bold
      text " \n1. Apresentando o lugar e os sujeitos protagonistas", :style => :bold, :size => 13
      text " \n1.1. O município", :style => :bold

      text "O município de Osasco possui uma história que se confunde em grande medida com a formação brasileira. Foi uma região de povoamento indígena da etnia Tupi-Guarani, no período pré-colonial, anterior ao século XVI. Durante o período colonial, nos séculos XVII e XVIII, abrigou um núcleo de bandeirantes.", :indent_paragraphs => 30
      text "No século XIX, com o processo de imigração, a cidade recebe muitos europeus, dentre os quais se destaca Antonio Agú. Ao chegar ao Brasil, em 1893, Agú, adquiriu terras circunvizinhas à capital paulista e nelas se fixou. Objetivando transformá-las num grande centro agrícola, loteou-as, e assim outros italianos foram chegando e instalando chácaras para produção de uva e limão. Entre os diversos empreendimentos, Antônio Agú construiu uma olaria, uma fábrica de tecidos e uma cartonagem, em sociedade com Narciso Sturlini. Em 1895, construiu uma estação ferroviária e a ofertou à Estação de Ferro Sorocabana, hoje FEPASA (da qual foi funcionário), pedindo à Diretoria da Empresa que a ela desse o nome de Osasco, em homenagem à sua cidade natal, na Itália. João Brícola, também imigrante italiano e que viera ao Brasil para trabalhar como engenheiro na Estrada de Ferro Paulista, construiu uma casa de campo na região e deu apoio a Antônio Agú na escolha do nome de Osasco.", :indent_paragraphs => 30
      text "A industrialização do subdistrito de Osasco, iniciada nos fins do século XIX, e impulsionada a partir da década de 1940, acabou por atrair mão de obra especializada e, consequentemente, mais moradores para o bairro. O caráter da urbanização mudou significativamente a localidade.", :indent_paragraphs => 30
      text "Do ponto de vista político, em 1918, foi criado o Distrito de Paz. Em 1938 e em 1944, passou à Zona Distrital (15ª) do Distrito-sede do Município de São Paulo e ao 14º. Subdistrito, respectivamente. Em 1953, começou a luta pela emancipação, realizando-se a 13 de dezembro desse mesmo ano o primeiro plebiscito. Cinco anos depois, no segundo plebiscito Osasco foi emancipado.", :indent_paragraphs => 30
      text "Embora o resultado do segundo plebiscito tenha sido homologado, decorreu muito tempo para que a questão ficasse definitivamente resolvida. O desligamento de Osasco da Capital somente ocorreu em 19 de janeiro de 1962, com a eleição para a primeira administração.", :indent_paragraphs => 30
      text "A partir da metade do século XX, a formação de um parque industrial faz também crescer o comércio na região.", :indent_paragraphs => 30
      text "Do ponto de vista político, a história de Osasco também é marcada por um passado fervoroso na luta contra a ditadura militar (1964-1985). A cidade foi palco de lutas históricas dos movimentos operários nos finais dos anos 1970 e 1980, tendo sido um cenário de grande importância estratégica que abrigou personalidades e lideranças políticas, como o o ex-presidente da República, Luiz Inácio Lula da Silva, na ocasião uma liderança sindical.<font size='6'>1</font>", :indent_paragraphs => 30, :inline_format => true
      text "Atualmente, o município tem uma intensa vida cultural, com teatros, cinemas, bibliotecas, escola de artes, espaços culturais, escolas de música e faculdades.", :indent_paragraphs => 30
      text "A população da cidade é de cerca de 700 mil habitantes (IBGE, 2010), concentrados no perímetro urbano. A densidade demográfica é de 10.055,36 habitantes por km², considerada alta. A taxa de mortalidade infantil para crianças de até 1 ano é de cerca de  13 por mil nascidos vivos (IBGE, 2010).", :indent_paragraphs => 30

      text "\n 1.2. As Unidades Educacionais", :style => :bold
      text "A rede municipal de educação de Osasco é constituída por 136 unidades educacionais que atendem a educação básica: Educação Infantil (Escola Municipal de Educação Infantil - EMEI e CRECHE), Ensino Fundamental (Escola Municipal de Ensino Fundamental – EMEF) e Educação de Jovens e Adultos (EJA) , incluindo as unidades associadas que funcionam em parceria com a Secretaria de Educação. Todas as unidades educacionais atendem as regiões central, norte e sul.", :indent_paragraphs => 30
      text "É possível as unidades prestarem atendimento a mais de um nível de ensino. Em Osasco, a rede está agrupada da seguinte forma:\n", :indent_paragraphs => 30

      table2 =  [["Nível de atendimento ","Quantidade de unidades"],["EMEF","45"],["EMEIEF","6"],["CEMEIEF","4"],["EMEI","36"],["CEMEI","11"],["CRECHE","31"],["Escolas Especiais","2"],["CEU","1"],["Escolas Conveniadas","26"],["EJA","40"]]
      table table2

      text " \n Entre as unidades educacionais da rede municipal de Osasco, destaca-se o Centro Educacional Unificado Zilda Arns - CEU, inaugurado no início de 2010 no Jardim Elvira, com piscina e quadra coberta, laboratórios de informática, amplo teatro e biblioteca com sala de exposições. A unidade beneficia tanto os educandos da rede municipal de ensino como a comunidade de bairros vizinhos ao Jardim Elvira.", :indent_paragraphs => 30

      text "\n 1.3. A composição da Rede", :style => :bold
      text "A rede municipal de Osasco atende  65.787 educandos sendo, 39.022 do Ensino Fundamental, 8.242 da creche e 15.856 da Educação Infantil, 2.389 na EJA e 278 na Educação Especial. Além da experiência em sala de aula, os educandos vivenciam experiências em eventos como a Conferência Lúdica, passeios com objetivos pedagógicos e outros projetos que ocorrem nas unidades educacionais. No caso do Ensino Fundamental, é possível citar: o projeto Escolinha do Futuro, que oferece aulas de xadrez, judô, futebol, capoeira, teatro e educação socioambiental; o projeto Sementes de Primavera, em que representantes de sala, aprendem a exercer a cidadania desde a infância, transformando a realidade das unidades educacionais com campanhas de sensibilização e mobilização acerca dos direitos dos educandos, na construção de uma escola cidadã.", :indent_paragraphs => 30
      text "As famílias dos educandos são representadas não só pelas mães ou pais mas também por parentes próximos. Suas participações acontecem em reuniões para acompanhar o desenvolvimento das crianças, colaborar com a unidade escolar na construção da festa cidadã e outras de cunho artístico-cultural. A participação das famílias se amplia na gestão escolar, por meio da APM e das reuniões do Conselho de Gestão Compartilhada  (CGC), instituído pela lei municipal nº 4136 - 05/06/2007, com o objetivo de fazer com que a escola tenha uma gestão democrática e participativa de forma que todos os segmentos envolvidos eleitos por seus pares, inclusive os educandos a partir de 9 anos de idade, deliberem sobre os assuntos do cotidiano.", :indent_paragraphs => 30
      text "A rede educacional de Osasco é composta por 4.866 professores distribuídos da seguinte forma:2.935 professores de educação básica - PEB-I (que atuam nas EMEIs, EMEFs e EJA) e 368 professores PEB–II e 1.563  professores na Creche. Os professores participam de cursos de capacitação e formação continuada no Centro de Formação de Osasco.", :indent_paragraphs => 30
      text "As unidades educacionais contam com os funcionários de apoio, que também exercem o papel de educadores no processo de aprendizagem dos educandos. Estes auxiliam na gestão escolar e são responsáveis pela limpeza, higiene, alimentação, matrícula e outros cuidados necessários e fundamentais para as crianças. Os gestores possuem um papel importante nas unidades educacionais: um na Educação Infantil e o trio gestor no Ensino Fundamental (com exceções para as unidades com mais de um nível de ensino, que possuem quatro gestores) e respondem pela unidade educacional no âmbito administrativo, pedagógico e financeiro.", :indent_paragraphs => 30

      text "\n 1.4. A Supervisão de Ensino", :style => :bold
      text "Com intuito de garantir uma comunicação mais próxima entre a Secretaria de Educação e as unidades educacionais, foi criado em 2009 o corpo de Supervisores de Ensino. Recrutados na própria rede de ensino, esses profissionais foram selecionados pela Secretaria, baseados na sua trajetória e experiência acumulada na gestão e trabalho na rede de Osasco.", :indent_paragraphs => 30
      text "Em 2010, o grupo é composto por 19 pessoas e  tem por objetivo mediar o contato entre a Secretaria e as unidades, dando suporte à gestão e colaborando para que os fluxos das ações necessárias aos projetos propostos pela Secretaria obtenham êxito. Em contrapartida, os supervisores procuram levar à Secretaria as demandas e requisições das unidades da rede, tornando a comunicação entre ambas mais eficaz.", :indent_paragraphs => 30
      text "O grupo divide-se em regiões e cada supervisor atua individualmente nas escolas, possuindo em média de 07 a 08 unidades para acompanhar.", :indent_paragraphs => 30
      text "Vale destacar que os supervisores de ensino têm sido de extrema relevância nas parcerias entre as assessorias, uma vez que acompanham as formações dos profissionais da rede (principalmente gestores e professores) e garantem a continuidade das ações quando estas têm que ser realizadas nas próprias unidades.", :indent_paragraphs => 30
      text "Um outro destaque desse grupo tem sido a sua atuação em conjunto com o Corpo Técnico no atendimento às famílias e crianças com necessidades especiais, garantindo a expansão e a efetividade das ações desenvolvidas por este.", :indent_paragraphs => 30

      text "\n 1.5. O Corpo Técnico Pedagógico (CTP)", :style => :bold
      text "O Corpo Técnico Pedagógico (CTP) foi criado em 2010 por meio da Portaria nº09/10, do dia 25/02/2010<font size='6'>1</font>, com o objetivo de formar um corpo de profissionais de áreas distintas como fonoaudiólogos, terapeutas ocupacionais, psicólogos, fisioterapeutas, assistentes sociais entre outros, visando o atendimento às famílias e principalmente às crianças com necessidades especiais, tendo como especificidade a orientação direta aos pais e profissionais das unidades educacionais, quanto ao tratamento das crianças, suas respectivas necessidades e deficiências.", :indent_paragraphs => 30, :inline_format => true
      text "O atendimento realizado por estes profissionais se caracteriza por visitas periódicas às unidades. Divididos por regiões, subgrupos do corpo técnico se deslocam até as escolas para orientar pais, gestores e principalmente professores, procurando manter uma agenda de visitas para garantir o acompanhamento da demanda. Suas ações abrangem problemas diversos, que perpassam as dificuldades na fala, deficiências intelectuais, dentre outros.", :indent_paragraphs => 30
      text "Os profissionais que compõem esse conjunto possuem uma larga trajetória no atendimento a crianças da rede, no entanto, em 2010 ampliaram suas ações, indo diretamente às unidades. Desta forma, potencializaram suas ações na medida em que passaram a estar mais próximos das unidades, podendo realizar orientações in loco, tornando o contato mais direto com a realidade vivida por cada criança em sua unidade e região. Os novos moldes de atuação desses profissionais, permitem que pais e filhos não necessitem deslocar-se até os serviços de atendimento, mas que o recebam diretamente na unidade.", :indent_paragraphs => 30
      text "\n" * 5
      text "<font size='10'><font size='6'>1</font> IOMO - Imprensa Oficial do Município de Osasco,  de 26 de fevereiro de 2010; Edição nº 702, Ano XIII; pp. 22 e 23.</font>", :inline_format => true

      start_new_page
      text "O trabalho desenvolvido pelo Corpo Técnico Pedagógico fortalece a parceria da escola com a família e cumpre com metas da política educacional, no que diz respeito ao acesso e permanência das crianças nas escolas, uma vez que aumenta a capacidade de atendimento das unidades e permite que as crianças não percam o dia de aula, podendo assim permanecer mais tempo na escola, integrando-se e interagindo com os demais educandos. Além de promover a inclusão, promove-se também a cidadania das crianças com deficiências e necessidades especiais.", :indent_paragraphs => 30

      start_new_page
      text "CAPÍTULO II. METODOLOGIA

        2.1. Foco da Avaliação

        Objetivos", :style => :bold

      text "• Avaliar os resultados e impactos do Programa Escola Cidadã e Inclusiva de Osasco na melhoria da qualidade da educação no município e identificar aspectos que precisam ser priorizados na política educacional.
        • Conhecer os resultados e impactos do Programa partir das representações e percepções dos segmentos envolvidos no processo educativo das unidades educacionais , isto é: educandos, familiares, professores, funcionários de apoio e gestores, tendo como referenciais os indicadores de qualidade social da educação.
        • Conhecer os resultados e impactos do Programa Escola Cidadã - PEC Osasco em dois níveis de ensino oferecidos pela Secretaria de Educação de Osasco: Ensino Fundamental (EMEF) e Educação Infantil (Creche e EMEI).
        • Correlacionar os dados obtidos na pesquisa avaliativa com os resultados do desempenho da unidade, provenientes do IDEB - Índice de Desenvolvimento da Educação Básica (no caso do Ensino Fundamental).
        • Correlacionar os dados obtidos na pesquisa avaliativa por agrupamento regional de escolas de Educação Infantil.
        • Contribuir para a continuidade e o desenvolvimento de uma cultura avaliativa, fortalecendo as relações de diálogo, cooperação, colaboração e compromisso de todos os envolvidos com o Programa, em todas as suas etapas."


      text "\n 2.2. Dimensões e Indicadores de Avaliação", :style => :bold
      text"Os indicadores são as referências que nos ajudam a responder às perguntas avaliativas. A proposição de indicadores é uma etapa fundamental do processo avaliativo. Se o espírito da avaliação está nas perguntas avaliatórias, que apontam o porquê de sua existência, os indicadores são os elementos concretos que levarão todos os interessados a visualizarem e a compreenderem uma imagem do objeto avaliado.", :indent_paragraphs => 30
      text "Os indicadores devem ser contextuais, relacionais e de medição das ações em si. Devem permitir procedimentos para observá-los e também medidas qualitativas e quantitativas.", :indent_paragraphs => 30
      text "A partir das premissas acima descritas, tomando como base as diretrizes da política educacional e inspirados nos documentos publicados pelo Ministério da Educação que definem os indicadores de qualidade na educação: Indicadores de Qualidade na Educação Infantil<font size='6'>2</font> e Indicadores de Qualidade na Educação<font size='6'>3</font>, identificamos um conjunto de elementos que julgamos serem fundamentais e que serviram de base na reflexão sobre a qualidade da escola que se quer para o município de Osasco. A esse conjunto de elementos que denominamos dimensões, indexamos um outro conjunto de elementos que servirão de sinalizadores de qualidade de importantes aspectos da realidade escolar - os indicadores.", :indent_paragraphs => 30, :inline_format => true
      text "Considerando que as diversas modalidades de ensino guardam especifidades singulares, a partir tanto das características dos segmentos envolvidos no processo educativo (educandos, familiares, professores, funcionários de apoio, gestores, comunidade) quanto das condições da oferta de ensino, tais como estrutura física das unidades, financiamentos, etc., construímos um conjunto de dimensões, e seus respectivos indicadores, para cada uma das modalidades de ensino, a saber: Escolas Municipais de Ensino Fundamental – EMEF e Educação Infantil (EMEI/Creche).", :indent_paragraphs => 30
      text " \n <font size='10'>
        <font size='6'>2</font> Indicadores de Qualidade na Educação Infantil – Ministério da Educação/Secretaria da Educação Básica – Brasília: MEC/SEB, 2009.
        <font size='6'>3</font> Indicadores da Qualidade na Educação - Ação Educativa, UNICEF, PNUD, INEP, SEB/MEC (coordenadores) – São Paulo: Ação Educativa,  2007, 3ª Edição.", :inline_format => true
      text "A seguir, detalhamos separadamente os conjuntos de Dimensões e Indicadores para cada um dos níveis de ensino e suas respectivas questões problematizadoras. Cabe destacar que tais questões referem-se a ações, atitudes, percepções e sentimentos que apontam as representações de cada segmento em relação ao indicador analisado.", :indent_paragraphs => 30
      table_with_dimensions_and_indicator = [
        ["<font size='13'><b>Indicadores da Qualidade Social na Educação do Ensino Fundamental</b></font>", "<font size='13'><b>Indicadores da Qualidade Social na Educação Infantil</b></font>"],
        ["<b>1. Ambiente Educativo</b>", "<b>1. Ambiente Educativo</b>"],
        ["1.1. Amizade e Solidariedade", "1.1. Amizade e Solidariedade"],
        ["1.2. Alegria",  "1.2. Alegria"],
        ["1.3. Combate à discriminação social",  "1.3. Combate à discriminação"],
        ["1.4. Disciplina e tratamento adequado aos conflitos que ocorrem no dia a dia", "1.4. Disciplina e tratamento adequado aos conflitos que ocorrem no dia a dia"],
        ["1.5. Respeito ao outro", "1.5. Respeito ao outro"],
        ["1.6. Respeito aos direitos das crianças e adolescentes", "1.6. Respeito aos direitos das crianças e adolescentes"],
        ["1.7. Respeito à dignidade das crianças", "1.7. Respeito à dignidade das crianças"],
        ["1.8. Respeito à identidade, desejos e interesses das crianças", "1.8. Respeito à identidade, desejos e interesses das crianças"],
        ["1.9 Respeito às ideias, conquistas e produções das crianças." , "1.9 Respeito às ideias, conquistas e produções das crianças."],
        ["1.10 Interação entre crianças e crianças","1.10 Interação entre crianças e crianças"],
        ["","1.11. Respeito ao ritmo das crianças"],
        ["<b>2. Ambiente Físico Escolar e Materiais</b>", "<b>2. Ambiente Físico Escolar e Materiais</b>"],
        ["2.1. Ambiente físico escolar", "2.1. Ambiente físico escolar"],
        ["2.2. Espaços e mobiliários que favoreçam as experiências das crianças", "2.2. Espaços e mobiliários que favoreçam as experiências das crianças"],
        ["2.3. Materiais variados e acessíveis às crianças", "2.3. Materiais variados e acessíveis às crianças"],
        ["2.4. Espaços, materiais e mobiliários para responder aos interesses e necessidades dos adultos", "2.4. Espaços, materiais e mobiliários para responder aos interesses e necessidades dos adultos"],
        ["<b>3. Planejamento Institucional e Prática Pedagógica</b>", "<b>3. Planejamento Institucional e Prática Pedagógica</b>"],
        ["3.1. Projeto Eco-Político-Pedagógico definido e conhecido por todos", "3.1. Projeto Eco-Político-Pedagógico definido e conhecido por todos"],
        ["3.2. Registro da prática educativa", "3.2. Registro da prática educativa"],
        ["3.3. Planejamento", "3.3. Planejamento"],
        ["3.4. Contextualização" , "3.4. Contextualização"],
        ["3.5. Incentivo à autonomia e do trabalho coletivo", "3.5. Incentivo à autonomia e do trabalho coletivo"],
        ["3.6. Variedade das estratégias e dos recursos de ensino-aprendizagem", "3.6. Variedade das estratégias e dos recursos de ensino-aprendizagem"],
        ["3.7. Prática Pedagógica de Apoio à Diversidade", "3.7. Prática Pedagógica de Apoio à Diversidade"],
        ["3.8. Multiplicidade de diferentes linguagens plásticas, simbólicas, musicais e corporais", "3.8. Multiplicidade de diferentes linguagens plásticas, simbólicas, musicais e corporais"],
        ["", "3.9 Experiências e aproximação com a linguagem oral e escrita"],
        ["<b>4. Avaliação</b>", "<b>4. Avaliação</b>"],
        ["4.1. Monitoramento do processo de aprendizagem do aluno", "4.1. Monitoramento do processo de aprendizagem do aluno"],
        ["4.2. Mecanismos de avaliação dos educandos", "4.2. Mecanismos de avaliação dos educandos"],
        ["4.3. Participação dos educandos na avaliação", "4.3. Participação dos educandos na avaliação"],
        ["4.4. Avaliação do trabalho dos profissionais da escola", "4.4. Avaliação do trabalho dos profissionais da escola"],
        ["4.5. Acesso, compreensão e uso dos indicadores oficiais de avaliação da escola",""],
        ["<b>5. Acesso e Permanência dos Educandos na Escola</b>", "<b>5. Acesso e Permanência dos Educandos na Escola</b>"],
        ["5.1. Atenção aos educandos com alguma defasagem de aprendizagem", "5.1. Atenção aos educandos com alguma defasagem de aprendizagem"],
        ["5.2. Atenção às necessidades educativas da comunidade", "5.2. Atenção às necessidades educativas da comunidade"],
        ["5.3. Atenção especial aos educandos que faltam" , "5.3. Atenção especial aos educandos que faltam"],
        ["5.4. Preocupação com o abandono e a evasão",""],
        ["<b>6. Promoção da Saúde</b>", "<b>6. Promoção da Saúde</b>"],
        ["6.1. Responsabilidade pela alimentação saudável das crianças", "6.1. Responsabilidade pela alimentação saudável das crianças"],
        ["6.2. Limpeza, salubridade e conforto", "6.2. Limpeza, salubridade e conforto"],
        ["6.3. Segurança", "6.3. Segurança"],
        ["6.4. Cuidados com a higiene e saúde", "6.4. Cuidados com a higiene e saúde"],
        ["<b>7. Educação Socioambiental e Práticas Ecopedagógicas</b>", "<b>7. Educação Socioambiental e Práticas Ecopedagógicas</b>"],
        ["7.1. Respeito às diversas formas de vida", "7.1. Respeito às diversas formas de vida"],
        ["7.2. Práticas ecopedagógicas", "7.2. Práticas ecopedagógicas"],
        ["<b>8. Envolvimento com as Famílias e Participação na Rede de Proteção Social</b>", "<b>8. Envolvimento com as Famílias e Participação na Rede de Proteção Social</b>"],
        ["8.1. Respeito e acolhimento e envolvimento com as famílias", "8.1. Respeito, acolhimento e envolvimento com as famílias"],
        ["8.2. Garantia do direito das famílias de acompanhar as vivências e produções das crianças", "8.2. Garantia do direito das famílias de acompanhar as vivências e produções das crianças"],
        ["8.3. Participação da Instituição na Rede de Proteção aos Direitos da Criança", "8.3. Participação da Instituição na Rede de Proteção aos Direitos da Criança"],
        ["<b>9. Gestão Escolar Democrática</b>", "<b>9. Gestão Escolar Democrática</b>"],
        ["9.1. Democratização da informação e da gestão", "9.1. Democratização da informação e da gestão"],
        ["9.2. Conselhos atuantes", "9.2. Conselhos atuantes"],
        ["9.3. Parcerias locais e relacionamento da escola com os serviços públicos", "9.3. Parcerias locais e relacionamento da escola com os serviços públicos"],
        ["9.4. Participação efetiva de estudantes, pais, responsáveis e comunidade em geral",""],
        ["<b>10. Formação e Condições de Trabalho dos Profissionais da Escola</b>", "<b>10. Formação e Condições de Trabalho dos Profissionais da Escola</b>"],
        ["10.1. Formação inicial e continuada", "10.1. Formação inicial e continuada"],
        ["10.2. Suficiência da equipe escolar e condições de trabalho", "10.2. Suficiência da equipe escolar e condições de trabalho"],
        ["10.3. Assiduidade da equipe escolar", "10.3. Assiduidade da equipe escolar"],
        ["<b>11. Processos de Alfabetização e Letramento (somente para as EMEFs)</b>",""],
        ["11.1. Orientações para a alfabetização inicial implementadas",""],
        ["11.2. Existência de práticas alfabetizadoras na escola",""],
        ["11.3. Atenção ao processo de alfabetização de cada criança",""],
        ["11.4. Ampliação da capacidade de leitura e escrita dos educandos ao longo do ensino",""],
        ["11.5. Acesso e aproveitamento da biblioteca e sala de leitura",""]
      ]
      table(table_with_dimensions_and_indicator, :cell_style => {:inline_format => true })
      text "\n2.3. Instrumentos", :style => :bold
      text "A partir da definição do conjunto de dimensões e indicadores foram desenvolvidos os instrumentais da pesquisa avaliativa, que é constituída de questionários estruturados para os diversos segmentos da comunidade escolar, isto é: educandos, familiares, profissionais de apoio e gestores. Os questionários foram compostos por perguntas agrupadas por indicadores e dimensões, e acompanhados por um gabarito geral cujas respostas seguiram a seguinte escala:", :indent_paragraphs => 30
      table_with_scales =  [
          ["0","Não sei"],
          ["1","Nunca ou Péssima"],
          ["2","Raramente ou Ruim"],
          ["3","Às vezes ou Regular"],
          ["4","Na maioria das vezes ou Bom"],
          ["5","Sempre ou Ótimo"]
        ]
      table table_with_scales
      text " \n"
      text "Ao final de cada dimensão foi reservado um espaço para que o mediador registrasse a síntese dos apontamentos do grupo em relação às práticas consolidadas e as que precisavam avançar, considerando as questões e os indicadores da dimensão avaliada, como no exemplo a seguir:", :indent_paragraphs => 30
      start_new_page
      table4 = [
          ["Práticas Consolidadas","Práticas que precisam avançar"],
          ["                                       \n\n\n\n\n\n\n\n\n\n\n\n","                                                                                                            "]
        ]
      table([["Descrição da síntese dos apontamentos do grupo a partir das questões e indicadores desta dimensão"],[table4]])

      text " \n Cabe destacar que  os instrumentais foram submetidos à apreciação do Corpo Técnico Pedagógico que compõe a Rede Municipal de Ensino de Osasco, o qual contribuiu para o aperfeiçoamento e fez adaptações consideradas necessárias.", :indent_paragraphs => 30
      text "Os instrumentais foram elaborados diferentemente para a Educação Infantil, para o Ensino Fundamental e para a Educação Especial (EMEE Prof. Edmundo Campanha Burjato), distribuídos da seguinte forma:", :indent_paragraphs => 30

      text " \n Quantidade de Dimensões, indicadores e questões por nível de ensino e segmento.", :indent_paragraphs => 30

      table5 = [["Segmento","Dimensões","Indicadores","Questões"],["Professores-Gestores","11","52","155"],["Funcionários de Apoio","11","43","142"],["Familiares","11","45","153"],["Educandos","11","31","48"]]
      table([["Ensino Fundamental"],[table5]])
      text "\n"
      table6 = [["Segmento","Dimensões","Indicadores","Questões"],["Professores-Gestores","10","46","148"],["Funcionários de Apoio","10","40","131"],["Familiares","10","38","131"]]

      start_new_page
      table([["Ensino Infantil"],[table6]])
      text "\n"
      table7 = [["Segmento","Dimensões","Indicadores","Questões"],["Familiares","11","43","142"],["Trabalhadores","11","49","178"]]
      table([["EMEE - Edmundo Campanha Burjato"],[table7]])

      text "\n 2.4.  Definição de amostragem", :style => :bold
      text "Em pesquisas de avaliação não existe um único método para calcular precisamente o tamanho da amostra necessária. É claro que quanto maior a amostra, mais precisas são as informações coletadas, porém, muitas vezes não é possível avaliar a totalidade da população. Logo, deve-se ponderar em primeiro lugar a viabilidade da coleta de dados que está relacionada principalmente ao custo, ao tempo do projeto ou do programa e a disponibilidade dos sujeitos, especialmente no que se refere às dificuldades de mobilização de familiares, educandos e outros segmentos participantes.", :indent_paragraphs => 30
      text "No caso das unidades de ensino que compõem a Rede Municipal de Educação de Osasco, em que o universo da população é bastante numeroso, optou-se por amostragem representativa dos vários segmentos da comunidade escolar, como segue:", :indent_paragraphs => 30

      table8_1 = [
          ["Segmentos","Amostra por unidade"],
          ["Familiares","Mín 10% por classe"],
          ["Funcionários de Apoio","Mín 50%"],
          ["Professores","Mín 50%"],
          ["Funcionários de Apoio","Mín 50%"],
          ["Gestores","100%"],
          [" "," "]
        ]

      table8_2 = [
          ["Segmentos","Amostra por unidade"],
          ["Familiares","Mín de 10% por classe"],
          ["Funcionários de Apoio","Mín de 50% "],
          ["Professores","Mín de 50%"],
          ["Funcionários de Apoio","Mín de 50%"],
          ["Gestores","100%"],
          ["Educandos","Mín de 10%"]
        ]
      table([["Educação Infantil", "Ensino Fundamental"],[table8_1, table8_2]])

      text "\n 2.5. Estratégias de Coleta de Dados", :style => :bold
      text "Tomando como base o cenário constituído pelas diversas unidades envolvidas na implementação do Programa, distribuído em 138 unidades de ensino e prevendo uma grande quantidade de respondentes por segmentos, pensou-se na aplicação do instrumento de pesquisa em subgrupos de respondentes, por segmento. Cada grupo  recebeu um conjunto de perguntas e seu respectivo gabarito. Foi sugerida a escolha de um mediador que conduzisse a discussão de cada pergunta no seu segmento, possibilitando que os participantes atribuíssem uma síntese numérica para a questão discutida, de forma individual.", :indent_paragraphs => 30
      text "Com a finalidade de assegurar o registro dos participantes no processo de avaliação foi orientado que cada grupo preenchesse uma lista de presença.", :indent_paragraphs => 30
      text "Ao final do preenchimento do gabarito de respostas coube a cada unidade de ensino a responsabilidade pela inserção dos resultados e lista de presença no sistema on-line. Uma vez que estes questionários foram aplicados no espaço institucional das Unidades de Ensino, estas foram as responsáveis pelo envolvimento e mobilização, especialmente das crianças e dos familiares, visando garantir o maior número possível de respondentes.", :indent_paragraphs => 30

      text "\n 2.6. Análise e interpretação dos dados", :style => :bold
      text "A técnica utilizada na análise foi a de triangulação dos dados quantitativos (advindos da análise estatística), dos dados qualitativos (resultantes das discussões sintetizadas ao final de cada dimensão) e das reflexões e aprendizagens com os principais interessados no processo de avaliação. A proposta de análise baseada na triangulação de dados caracteriza, atualmente, as pesquisas na área de ciências humanas, da saúde, e da educação, inclusive aquelas aplicadas à área do desenvolvimento de projetos e programas sociais. De acordo com Patton<font size='6'>4</font>(1987), a triangulação é considerada fundamental para verificar a propriedade das interpretações apoiadas em dados quantitativos e qualitativos, e permite observar a realidade a partir de diferentes ângulos, o que possibilita uma discussão interativa dos dados. Nesse sentido, a avaliação por triangulação de dados se constitui como uma contribuição positiva e inovadora no avanço de políticas públicas e sociais no Brasil.", :indent_paragraphs => 30, :inline_format => true

      image "#{RAILS_ROOT}/public/relatorios/artifacts/triangle_image.jpg", :scale => 0.5, :position => :center

      text "\n As apresentações e análises dos resultados seguem as seguintes etapas
        \n 2.6.1. Análise estatística e descritiva dos dados da rede de ensino por nível de atendimento", :style => :bold
      text "A primeira etapa contemplou a geração de dados estatísticos a partir das informações inseridas no sistema on-line. Essa primeira análise foi elaborada pela equipe do Instituto Paulo Freire e comunicada através de gráficos e mapas aos interessados no processo de avaliação, isto é: as unidades educacionais, aos membros da Secretaria de Educação de Osasco e   ao Corpo Técnico Pedagógico.", :indent_paragraphs => 30
      text "A análise estatística apresentada  segue a mesma organização do instrumental das questões que as unidades responderam, isto é, em dimensões e indicadores. Os resultados e análises apresentadas seguem a estrutura detalhada a seguir:", :indent_paragraphs => 30
      text " \n <font size='10'><font size='6'>4</font> Patton MQ. Qualitative evaluation methods. London: Sage Publications, 1987.</font>", :inline_format => true

      text "\n Educação Infantil e Ensino Fundamental", :style => :bold
      table_with_structure = [
        ["Identificação da dimensão: \n Nome e breve contextualização da dimensão."],
        ["Gráfico geral da rede sobre a dimensão: \n Neste gráfico podemos observar e analisar as médias dos resultados gerais  das percepções da Rede de Ensino por segmentos."],
        ["Gráficos gerais das percepções da rede sobre os indicadores: \n Nestes gráficos podemos observar e analisar as médias dos resultados gerais das percepções da Rede de Ensino por segmentos."],
        ["Questões problematizadoras: \n Ao final de cada dimensão, algumas questões são colocadas para reflexão mais aprofundada acerca da dimensão. O diálogo acerca destas questões contribui para que a Secretaria da Educação possa refletir sobre as metas estabelecidas no PME de 2009, quais foram alcançadas e quais ainda merecem atenção."]
      ]

      table table_with_structure

      text "\n 2.6.2. Organização, sistematização e análise de conteúdo de dados qualitativos", :style => :bold
      text "Essa etapa contempla a organização, a sistematização e análise de conteúdo dos dados qualitativos gerados ao final de cada dimensão.", :indent_paragraphs => 30

      image "#{RAILS_ROOT}/public/relatorios/artifacts/table_with_dimensions_about_practices.jpg", :scale => 0.8, :position => :center

      text "\n 2.6.3. Análise dos resultados das dimensões por agrupamentos, segundo estratos do IDEB no caso do Ensino Fundamental", :style => :bold

      table_emef_groups = [
        ["GRUPO A", "GRUPO B","GRUPO C", "GRUPO D"],
        ["Unidades Educacionais que não atingiram a meta projetada para ela em 2007 e apresentam IDEB inferior ao da rede municipal.",
        "Unidades Educacionais que atingiram ou ultrapassaram a meta projetada para ela em 2007 mas mantiveram o seu IDEB inferior ao da rede municipal.",
        "Unidades Educacionais que não atingiram a meta projetada para ela em 2007 e apresentam IDEB igual ou superior ao da rede municipal.",
        "Unidades Educacionais que atingiram ou ultrapassaram a meta projetada para ela em 2007 e apresentam IDEB igual ou superior ao da rede municipal."],
        ["EMEIEF Elio Aparecido", "EMEF Terezinha Martins Pereira", "EMEIEF Messias Gonçalves da Silva", "CEMEIEF Maria José Ferreira Ferraz"],
        ["EMEF Frei Gaspar da Madre de Deus", "EMEF Prof. Manoel Barbosa de Souza", "EMEIEF Etiene Sales Campelo Profa", "CEMEI Maria Tarcilla Fornasaro Melli"],
        ["EMEF Dr. Francisco Manuel L Sa Carneiro", "EMEF Josias Baptista Pastor", "EMEF Prof. Olavo Antonio Barbosa Spinola", "EMEF Profa. Marina Von Putkammer Melli"],
        ["EMEF Marina Saddi Haidar", "EMEF Deputado Alfredo Farhat", "EMEF João Guimarães Rosa", "EMEF Benedicto Weschenfelder"],
        ["EMEF Domingos Blasco Maestro", "EMEF Prof. Olinda Moreira Lemes da Cunha", "EMEF Prof. Luciano Felicio Biondo", "EMEF Mal. Bittencourt"],
        ["EMEF Dr. Hugo Ribeiro de Almeida", "EMEF Irma Tecla Merlo", "EMEF Tobias Barreto de Menezes", "EMEF Francisco Cavalcanti Pontes Miranda"],
        ["EMEF Prof. João Campestrini", "EMEF Oscar Pennacino", "EMEF Profa. Cecília Correa Castelani", "EMEF Prof. Laerte José dos Santos"],
        ["EMEIEF Valter de Oliveira", "EMEF Elidio Mantovani Monsenhor", "EMEF Prof. Elza de Carvalho Mello Battiston", "EMEF Dr. José Manoel Ayres"],
        ["EMEF Saad Bechara", "CEU Dra. Zilda Arns Neumann", "EMEF Luiz Bortolosso", "EMEF Prof. Renato Fiuza Teles"],
        ["EMEF Prof. Alipio da Silva Lavoura", "CEMEIEF Prof. Darcy Ribeiro", "EMEF Osvaldo Quirino Simões", "EMEF Prof. Anezio Cabral"],
        ["EMEF Prof. Oneide Bortolote", "EMEF José Veríssimo de Matos", "EMEF General Antonio de Sampaio", "EMEF José Martiniano de Alencar"],
        ["EMEF Prof. João Euclides Pereira", "", "EMEF Alice Rabechini Ferreira", "EMEF Prof. Max Zendron"],
        ["EMEF Quintino Bocaiuva", "", "", "EMEF Escultor Victor Brecheret"]
        ]

      table [["AGRUPAMENTO DE EMEFs"],[table_emef_groups]]

      start_new_page
      table [
        ["EMEF Profa. Zuleica Gonçalves Mendes", "", "", "EMEF Padre José Grossi Dias"],
        ["", "                                                                 ", "                                                        ", "EMEF Prof. João Larizzatti"],
        ["", "                                                                 ", "                                                        ", "EMEF Benedito Alves Turibio"],
        ["", "                                                                 ", "                                                        ", "EMEF Manoel Tertuliano de Cerqueira"]]

      start_new_page
      text "2.6.4. Análise dos resultados das dimensões por agrupamentos regionais, no caso da Educação Infantil", :style => :bold

      table_creche_groups = [["grupo 1","grupo 2","grupo 3","grupo 4"],
        ["Creche Benedita de Oliveira","Creche Elza Batiston","Creche Vilma Catan","Creche Amélia Tozzeto"],
        ["CEMEI Lourdes Candida","Creche Sadamitu Omosako","Creche Maria José da Anunciação","Creche José Espinosa"],
        ["CEMEI Wilma Foltran","Creche Prof. Silvia Ferreira Farhat","Creche Seraphina Bissolati","Creche Alha Elias Abib"],["CMEIEF Maria José Ferreira Ferraz","CEU Zilda Arns","CEMEIEF Maria Tarsilla","Creche Giuseppa"],["CEMEI Rubens Bandeira","Creche Alzira Silva","Creche Lar da Infância","CEMEI José Ermírio"],["CEMEI João de Farias","Creche Olga Camolesi","Creche Pedro Penov","CEMEI Mário Quintana"],["Creche Prof. Joaquina França","CEMEI Leonil Crê","Creche Moacyr Ayres","Creche Mercedes Correa"], ["CEMEI Fortunato Antiório","Creche Rosa Broseguini","Creche Hilda","Creche Dayse Ribeiro"],["CEMEI Mário Sebastião","Creche Ézio Melli","Creche Rosa Pereira Crê","Creche Sergio Zanardi"],["CEMEIEF Darcy Ribeiro","","Creche Lídia Thomaz","Cemei Zaira Colino"],
        ["  ","  ","Creche João Correa","Creche Recanto Alegre"],["  ","  ","Creche Ida Belmonte","CEMEI Alberto Santos Dumont"],
        ["  ","Creche Olímpia Maria de Jesus Carvalho","Creche Hermínia Lopes","Creche Inês Sanches Mendes"]]
      table [["AGRUPAMENTO DE CRECHES"],[table_creche_groups]]
      text "\n"

      table_emei_groups = [["grupo 1","grupo 2","grupo 3","grupo 4"],["EMEI Maria Bertoni Fiorita","EMEI Maria Alves Dória","EMEI Helena Coutinho","CEMEI Zaíra Collino"],["EMEI Omar Ogeda","EMEI Nair Bellacoza","EMEI Pedro Martino","EMEI Cristine"],["EMEI Japhet Fonte","EMEIEF Valter de Oliveira","EMEI Maria Madalena Freixeda","CEMEI Alberto Santos Dumont"],["CEMEI Lourdes Candida","CEU Zilda Arns","EMEI Alípio Pereira","EMEI Osvaldo Salles"],["CEMEI Wilma Foltran","EMEI Gertrudes de Rossi","EMEI Estevão Brett","EMEI Esmeralda"],["EMEI Osvaldo Gonçalves","CEMEI Leonil Crê","CEMEIEF Maria Tarcilla","EMEIEF Messias"],["EMEI Yolanda Botaro","EMEI Sonia Maria ","EMEI Dalva Mirian","EMEI Emir Macedo"], ["CEMEI Fortunato Antiório","EMEI Maria Ap. Damy","EMEI Fernando Buonaduce","EMEI Descio Mendes"],
        ["CEMEI Mário Sebastião","  ","EMEI Fortunata","EMEI Zuleica"],["CEMEIEF Darcy Ribeiro","  ","EMEI Elide Alves","CEMEI José Emírio"],
        ["EMEI Vivaldo","  ","EMEI Adhemar Pereira","CEMEI Mário Quintana"],["CEMEIEF Maria José Ferreira Ferraz","  ","EMEIF Etiene","EMEI Salvador Sacco"],
        ["CEMEI Rubens Bandeira","  ","EMEI Providencia dos Anjos"," "],["CEMEI João de Farias"," ","EMEI Ignes Collino"," "],
        ["EMEI José Flávio","  ","EMEI Antonio Paulino Ribeiro","  "],["EMEI Elio Aparecido da Silva","  ","EMEI Luzia Momi Sasso","  "],
        ["","  ","EMEI Severino de Araujo Freire","  "],["","  ","EMEI Thereza Bianchi Collino","  "]]
      start_new_page
      table [["AGRUPAMENTO DE EMEIs"],[table_emei_groups]]

      text "\n"
      start_new_page

      text "\n 2.6.5. Análise do índice das unidades por dimensão", :style => :bold
      text "Com base nos dados obtidos pela totalidade de unidades educacionais, foi estabelecido um <b>índice para cada UE</b>, em cada dimensão, utilizando a seguinte metodologia: ", :indent_paragraphs => 30, :inline_format => true
      text "A soma das respostas dadas pelos segmentos, dividida pela máxima pontuação que a unidade educacional poderia atribuir a si mesma, isto é: a média 5 dentro de cada dimensão. Por exemplo: numa determinada dimensão, 8 pessoas expressaram sua opinião numérica para as 10 questões contidas nela. Se 5 era a máxima opinião numérica que se podia dar, para essa dimensão a máxima pontuação que a UE poderia receber é 400, ou seja, 8 vezes 10, que é igual a 80, vezes 5, que é igual a 400. Contudo, a soma obtida pela UE, a partir da opinião dessas oito pessoas a essas 10 questões, foi de 240. O índice obtido pela UE, nessa dimensão, é obtido dividindo 240 por 400, ou seja: 0,6. Quanto mais próximo do 1,0, melhor o índice obtido pela unidade.", :indent_paragraphs => 30

      image "#{RAILS_ROOT}/public/relatorios/artifacts/table_with_formula.jpg", :scale => 0.7, :position => :center

      text " \n Ao propor um índice de análise para a sua unidade educacional, busca-se construir alternativas que permitam à comunidade escolar avaliar o seu êxito, comparando o atual ano letivo com os anteriores, além de perceber-se em relação às demais unidades que integram a Rede de Osasco, sem jamais pretender o estabelecimento de ranking entre as escolas. Considerando as complexidades típicas de uma rede pública de ensino, a construção de índices e sínteses numéricas associadas a conjuntos de indicadores de qualidade, definidos não arbitrariamente mas democraticamente, favorecem uma melhor gestão das suas demandas e necessidades.
        Apresentaremos estes resultados em forma de quadro das unidades de acordo com as suas pontuações, seguindo a seguinte escala:", :indent_paragraphs => 30

      show_table_with_index_by_unit

      text "\n 2.6.6. Reflexão e aprendizagem compartilhada", :style => :bold
      text "Esta etapa apresenta a sistematização das reflexões advindas dos encontros com os principais envolvidos no processo de avaliação, isto é, supervisores de ensino, membros do Corpo Técnico Pedagógico e membros do Observatório, sobre os resultados e análises dos dados. Nesse momento, com base nos gráficos e mapas, foram produzidas as reflexões, conclusões e recomendações para a atualização do PTA da Secretaria de Educação e para a construção do PME de 2011.", :indent_paragraphs => 30

      start_new_page
      text "CAPÍTULO III. RESULTADOS DA AVALIAÇÃO DO PEC-OSASCO 2010 - ENSINO INFANTIL", :style => :bold
      data = get_total_number_of_people_that_answered_the_surveys

      table13 = [
        ["Segmento","Total da rede","Total que responderam os questionários"," % "],
        ["Gestor","341",data["Gestores"],((data["Gestores"].to_i*100)/341)],
        ["Professor","4866",data["Professores"],((data["Professores"].to_i*100)/4866)],
        ["Funcionários de apoio","2089",data["Funcionarios"],((data["Funcionarios"].to_i*100)/2089)],
        ["Familiar *","32893",data["Familiares"],((data["Familiares"].to_i*100)/32893)],
        ["Educandos","39022",data["Educandos"],((data["Educandos"].to_i*100)/39022)]
      ]
      text "\n"
      table table13
      text "* considerando 1 representante dos familiares para cada 2 alunos."

      text "\n 3. Análise dos Resultados da Educação Infantil", :style => :bold, :size => 13
      text " \n3.1. Análise dos dados, por dimensões e indicadores", :style => :bold

      text "A seguir apresentamos os gráficos e mapas dos resultados obtidos, por dimensão. Sugerimos as seguintes questões para serem refletidas em todas as dimensões:", :indent_paragraphs => 30
      text "1. A partir da leitura detalhada dos resultados por dimensões, quais indicadores merecem atenção especial?", :indent_paragraphs => 30
      text "2. Há diferenças significativas entre as visões dos segmentos a respeito dos indicadores? Se sim, como podemos interpretar estas diferenças? Que fatores podem ter contribuído para este resultado?", :indent_paragraphs => 30
      text "3. É possível identificar correlação entre as médias apresentadas e a qualidade das ações propostas nos PTAs das unidades?", :indent_paragraphs => 30
      text "4. Existem movimentos organizados pela Secretaria que permitam às unidades compartilharem suas boas práticas relacionadas aos indicadores/dimensão analisada?", :indent_paragraphs => 30
      text "5. Que ações devem partir da Secretaria para que a rede melhore seu desempenho nestes indicadores/ dimensão? Qual deve ser o papel dos supervisores nestas ações?", :indent_paragraphs => 30
      text "6. Olhando para as nossas metas, tanto aquelas previstas pelas diretrizes estabelecidas pelo Plano de Desenvolvimento da Educação (decreto nº 6.094, 24 de abril de 2007), denominadas “Compromisso Todos pela Educação” como pelo PME de 2009 e cotejando-as com os resultados da avaliação, por dimensões e indicadores, conseguimos alcançá-las com êxito? Quais não conseguimos e quais serão os nossos esforços para melhorar a educação que oferecemos para as crianças e jovens do município?", :indent_paragraphs => 30

      start_new_page
      text "3.1.1 Dimensão 1. Ambiente Educativo", :style => :bold
      text "O Ambiente Educativo visa fornecer indicadores do ambiente que predomina na escola, das relações entre os diversos segmentos, do grau de conhecimento e participação deles na elaboração dos princípios de convivência e no conhecimento que se tem dos direitos das crianças, tendo em vista sua importância como referência às ações educativas para a escola. A escola é um dos espaços de ensino, aprendizagem e vivência de valores. Nela, os indivíduos se socializam, brincam e experimentam a convivência com a diversidade humana. No ambiente educativo, o respeito, a alegria, a amizade e a solidariedade, a disciplina, a negociação, o combate à discriminação e o exercício dos direitos e deveres são práticas que garantem a socialização e a convivência, desenvolvem e fortalecem a noção de cidadania e de igualdade entre todos.", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/infantil/general_average_dimension1-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"

      insert_graphics(%w(1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 1.10 1.11), "infantil")
      start_new_page
      text "c) Questões problematizadoras:"

      text "1. Em que medida as ações do CTP podem contribuir para a elaboração dos princípios de convivência da UE com a participação de todos os segmentos?", :indent_paragraphs => 30
      text "2. O conhecimento que as unidades têm sobre o ECA, revelado pela avaliação de 2010, tem sido suficiente? Tem sido referência em todas as ações educativas da UE? O que o CTP pode fazer em relação a isso?", :indent_paragraphs => 30
      text "3. Os resultados revelados pela avaliação de 2010 demonstram que há práticas suficientes nas UEs em relação à socialização e convivência? O que o CTP pode fazer para melhorar essa questão nas unidades?", :indent_paragraphs => 30

      start_new_page
      text "3.1.2. Dimensão 2. Ambiente Físico Escolar e Materiais", :style => :bold
      text "O ambiente físico escolar está diretamente relacionado à qualidade social da educação. Este deve ser atrativo, organizado, limpo, arejado, agradável, com árvores e plantas. Deve ainda dispor de móveis, equipamentos e materiais didáticos acessíveis, adequados à realidade da escola e que permitam a prestação de serviços de qualidade aos alunos, aos pais e a toda a comunidade.", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/infantil/general_average_dimension2-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(2.1 2.2 2.3 2.4), "infantil")

      start_new_page
      text "c) Questões problematizadoras:"
      text "1. O que os resultados revelam sobre a percepção dos segmentos acerca desta dimensão e seus indicadores? Quais fatores podem influenciar estas percepções?", :indent_paragraphs => 30
      text "2. É possível formular hipóteses sobre a forma como o subsídio recebido pelas unidades tem sido utilizado? As unidades têm investido em melhorias? É possível observar alguma tendência na priorização de determinados itens? É possível avaliar se o subsídio tem sido suficiente ou bem gerido?", :indent_paragraphs => 30
      text "3. As iniciativas da Secretaria relacionadas à troca de mobília ou envio de materiais como livros e outros tiveram reflexo nas médias apresentadas?", :indent_paragraphs => 30
      text "4. As unidades em que foram realizadas reformas tiveram uma boa avaliação nesta dimensão? O que as médias revelam sobre a possibilidade de participação ativa dos segmentos na tomada de decisões no processo de reforma?", :indent_paragraphs => 30
      text "5. O que os resultados revelam acerca da implantação da RECEI e RECEF nas unidades? Os resultados revelam que as unidades estão dedicadas a relacionar espaço físico e aprendizagem?", :indent_paragraphs => 30
      text "6. O espaço físico e materiais contemplam as necessidades dos diferentes segmentos? Que responsabilidades e ações devem partir da Secretaria para que a Rede melhore seu desempenho nestes indicadores/ dimensão? Qual deve ser o papel dos supervisores nestas ações?", :indent_paragraphs => 30
      text "7. O que os dados revelam sobre os objetivos e metas traçados no PME relativos a esta dimensão?", :indent_paragraphs => 30

      start_new_page
      text "3.1.3. Dimensão 3. Planejamento Institucional e Prática Pedagógica", :style => :bold
      text "Essa dimensão visa fornecer indicadores sobre o processo fundamental da escola: fazer com que os educandos aprendam e adquiram o desejo de aprender cada vez mais e com autonomia. Construção de uma proposta pedagógica bem definida e a necessidade de um planejamento com base em conhecimentos sobre o que os educandos já possuem e o que eles precisam e desejam saber são indicadores fundamentais de uma prática pedagógica centrada no desenvolvimento dos educandos.", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/infantil/general_average_dimension3-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9), "infantil")

      start_new_page
      text "c) Questões problematizadoras:"
      text "1. O que os resultados revelam acerca da implantação da RECEI e RECEF nas unidades? As ações promovidas pela Secretaria, como formações e encontros estão refletindo mudanças significativas?", :indent_paragraphs => 30
      text "2. O que os dados revelam sobre a participação e compreensão dos segmentos acerca do Projeto Eco-Político-Pedagógico? Ele vem sendo construído coletivamente? Que ações devem ser encabeçadas pela Secretaria para que isto seja assegurado?", :indent_paragraphs => 30
      text "3. O que os dados revelam sobre os compromissos assumidos com as diretrizes estabelecidas pelo Plano de Desenvolvimento da Educação (decreto nº 6.094, 24 de abril de 2007), denominadas “Compromisso Todos pela Educação”?", :indent_paragraphs => 30
      text "4. O que os dados revelam sobre os objetivos e metas traçados no PME relativos a esta dimensão?", :indent_paragraphs => 30

      start_new_page
      text "3.1.4. Dimensão 4. Avaliação", :style => :bold
      text "Essa dimensão visa fornecer os indicadores que dizem respeito à prática da avaliação como parte integrante e fundamental do processo educativo. Monitoramento do processo de aprendizagem, mecanismos e variedades de avaliação, participação dos educandos no processo de avaliação da aprendizagem; autoavaliação; avaliação dos profissionais e da escola como um todo; discussão e reflexão sobre as avaliações externas implementadas pelo MEC são indicadores fundamentais que apontam se a escola vem construindo a cultura da avaliação, pressuposto fundamental para o desenvolvimento de uma educação de qualidade, que garanta o direito de aprender.", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/infantil/general_average_dimension4-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(4.1 4.2 4.3 4.4), "infantil")
      start_new_page
      text "c) Questões problematizadoras:"

      text "1. O que os dados revelam sobre a cultura de avaliação nas unidades?", :indent_paragraphs => 30
      text "2. Os dados sobre a avaliação dos educandos estão coerentes com a proposta da RECEI e RECEF? Que ações devem ser propostas pela Secretaria para assegurar esta coerência?", :indent_paragraphs => 30
      text "3. Os dados revelam uma cultura de avaliação dos profissionais das escolas? Que ações a Secretaria pode propor a fim de promover/fomentar esta cultura? Que papel os supervisores devem exercer neste processo?", :indent_paragraphs => 30
      text "4.As escolas estão utilizando os indicadores e dados das avaliações oficiais no seu dia a dia? Que ações a Secretaria de Educação propõe para que estes dados sejam atualizados, conhecidos e utilizados por todos?Em que medida a política educacional do município é pautada por estes dados e indicadores?", :indent_paragraphs => 30
      text "5. O que os dados revelam sobre os compromissos assumidos com as diretrizes estabelecidas pelo Plano de Desenvolvimento da Educação (decreto nº 6.094, 24 de abril de 2007), denominadas “Compromisso Todos pela Educação”?", :indent_paragraphs => 30

      start_new_page
      text "3.1.5 Dimensão 5. Acesso e Permanência dos Educandos na Escola", :style => :bold
      text "Esta dimensão visa fornecer indicadores sobre como a escola tem tratado a questão da democratização do acesso do aluno à instituição educativa, das faltas, da evasão e do abandono e dos esforços que a escola vem promovendo para fazer com que os educandos que evadiram ou abandonaram voltem para a escola. O acesso, ou seja, a matrícula, é a porta inicial para a democratização, mas torna-se necessário, também, garantir o direito de todos os que ingressam na  escola a condições de nela permanecer com sucesso (ou seja, permanecer e “aprender” na escola), sem interrupções até o término de um ciclo. Essa dimensão trata ainda da identificação dos indicadores referentes às necessidades educativas das respectivas comunidades.", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/infantil/general_average_dimension5-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(5.1 5.2 5.3), "infantil")

      start_new_page
      text "c) Questões problematizadoras:"
      text "1. Que ações o município desenvolve para garantir o acesso e permanência dos educandos na escola? Como estas políticas podem ser avaliadas tendo como base as médias obtidas nos diversos segmentos?", :indent_paragraphs => 30
      text "2. Os dados revelam ações no sentido de atender às necessidades educativas da comunidade? Que fatores podem influenciar a existência / inexistência destas ações?", :indent_paragraphs => 30
      text "3. Que ações o município tem realizado para garantir que os profissionais estejam bem preparados para atender os alunos com alguma defasagem de aprendizagem? De acordo com os resultados, é possível afirmar que estes esforços têm gerado os impactos desejados?", :indent_paragraphs => 30
      text "4. Que ações o município tem realizado para minimizar os casos de evasão e abandono nas unidades? De acordo com os resultados, é possível afirmar que estes esforços têm gerado os impactos desejados?", :indent_paragraphs => 30
      text "5. O que os dados revelam sobre os compromissos assumidos com as diretrizes estabelecidas pelo Plano de Desenvolvimento da Educação (decreto nº 6.094, 24 de abril de 2007), denominadas “Compromisso Todos pela Educação”?", :indent_paragraphs => 30
      text "6. O que os dados revelam sobre os objetivos e metas traçados no PME relativos a esta dimensão?", :indent_paragraphs => 30

      start_new_page
      text "3.1.6. Dimensão 6. Promoção da Saúde", :style => :bold
      text "A dimensão Promoção da Saúde se relaciona com os indicadores que dizem respeito às práticas cotidianas e os cuidados que a instituição tem com relação à saúde das crianças e dos adultos da escola. A atenção à saúde das crianças é um aspecto muito importante do trabalho em instituições de educação. As práticas cotidianas precisam assegurar a prevenção de acidentes, os cuidados com a higiene e uma alimentação saudável, para o bom desenvolvimento das crianças em idade de crescimento.", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/infantil/general_average_dimension6-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(6.1 6.2 6.3 6.4), "infantil")

      start_new_page
      text "c) Questões problematizadoras:"
      text "1. Que ações a Secretaria da Educação desenvolve estão diretamente ligadas à promoção da saúde? Estas ações estão sendo eficazes e efetivas? Que novas ações precisam ser desenvolvidas para que estes resultados sejam melhorados?", :indent_paragraphs => 30
      text "2. As parcerias da Secretaria da Educação com outras secretarias (como saúde e abastecimento) e organizações estão se desenvolvendo de forma adequada? Como os dados revelam isso? É preciso buscar novas parcerias?", :indent_paragraphs => 30
      text "3. A Secretaria tem conhecimento do perfil epidemiológico de seus alunos e alunas para melhorar direcionar as políticas públicas voltadas para a promoção da saúde?", :indent_paragraphs => 30
      text "4. O que os dados revelam sobre os compromissos assumidos com as diretrizes estabelecidas pelo Plano de Desenvolvimento da Educação (decreto nº 6.094, 24 de abril de 2007), denominadas “Compromisso Todos pela Educação”?", :indent_paragraphs => 30

      start_new_page
      text "3.1.7. Dimensão 7. Educação Socioambiental e Práticas Ecopedagógicas", :style => :bold
      text "A dimensão Educação Socioambiental e Práticas Ecopedagógicas visa fornecer indicadores sobre a formação em torno dos temas da cidadania planetária e as práticas educativas que garantem o conhecimento da realidade e a participação na construção de uma sociedade sustentável, com fundamentos da ecopedagogia.", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/infantil/general_average_dimension7-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(7.1 7.2), "infantil")

      start_new_page
      text "c) Questões problematizadoras:"
      text "1. Os resultados das avaliações das unidades revelam suficiência nas formações em torno dos temas da cidadania planetária e da sustentabilidade?", :indent_paragraphs => 30
      text "2. O que o CTP pode planejar para incentivar práticas educativas que garantam o conhecimento da realidade e a participação de toda comunidade escolar na construção de uma sociedade sustentável?", :indent_paragraphs => 30
      text "3. Tendo em vista que um dos princípios e objetivos do sistema municipal de educação de Osasco é o compromisso com a promoção e o incentivo à cultura da educação ambiental, nas instituições públicas e privadas, pró-recuperação e conservação dos recursos naturais, do desenvolvimento sustentável e da paz, como a rede educacional lida com a questão socioambiental? Temos conseguido desenvolver uma educação socioambiental e práticas ecopedagógicas consistentes?", :indent_paragraphs => 30

      start_new_page
      text "3.1.8. Dimensão 8. Envolvimento com as Famílias e Participação na Rede de Proteção Social", :style => :bold
      text "A dimensão Envolvimento com as Famílias e Participação na Rede de Proteção Social visa fornecer os indicadores que apontam se as famílias vêm sendo acolhidas pela escola e em que medida a escola vem garantido o direito das famílias acompanharem as vivências e produções das crianças. Essa dimensão visa ainda a fornecer os indicadores que apontam em que medida se dá a articulação da escola com a Rede de Proteção aos Direitos das Crianças, pois a instituição escolar é responsável, juntamente com as famílias, por garantir os direitos das crianças. Também visa refletir como os demais serviços públicos de alguma forma estão contribuindo para que todas as crianças sejam, de fato, sujeitos de direitos, conforme preconiza o Estatuto da Criança e do Adolescente (ECA).", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/infantil/general_average_dimension8-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(8.1 8.2 8.3), "infantil")

      start_new_page
      text "c) Questões problematizadoras:"
      text "1. Quanto maior e mais positiva for a interação entre a escola e os familiares e a comunidade a que ela atende, maior é a probabilidade de a escola oferecer aos seus educandos um ensino de qualidade. Diante dessa afirmação, como estamos promovendo a cooperação e o envolvimento com as famílias de nossa comunidade? A as unidades da rede municipal procuram conhecer e trocar experiências com as famílias e com a comunidade?", :indent_paragraphs => 30
      text "2. A rede municipal tem propiciado às unidades momentos que favoreçam vínculos positivos de parceria com os familiares dos educandos? Quais? De que forma eles são percebidos pelos diferentes segmentos e de que forma impactam no aprendizado e interesse e prazer da criança pelos estudos?", :indent_paragraphs => 30
      text "3. A  Secretaria busca mapear e identificar os equipamentos sociais que existem no município que possam contribuir para a constituição de uma rede de proteção social dos direitos das crianças? Como estas informações são divulgadas para as unidades? Como estas informações são divulgadas pelas unidades para a comunidade escolar?", :indent_paragraphs => 30
      text "4. A Secretaria estimula que as unidades articulem estreito relacionamento com a Rede de Proteção aos direitos das crianças existentes em seu entorno?", :indent_paragraphs => 30
      text "5. A Secretaria estimula e propicia momentos em que os profissionais da educação se atualizem no tocante à observação dos educandos com possíveis sinais de negligência e violência física e psicológica?", :indent_paragraphs => 30
      text "6. A Secretaria estimula as unidades criarem procedimentos de proteção ao constatarem sinais de violência e desrespeito à integridade das crianças?", :indent_paragraphs => 30
      text "7. O que os dados revelam sobre os compromissos assumidos com as diretrizes estabelecidas pelo Plano de Desenvolvimento da Educação (decreto nº 6.094, 24 de abril de 2007), denominadas “Compromisso Todos pela Educação”?", :indent_paragraphs => 30
      text "8. O que os dados revelam sobre os objetivos e metas traçados no PME relativos a esta dimensão?", :indent_paragraphs => 30

      start_new_page
      text "3.1.9. Dimensão 9. Gestão Escolar Democrática", :style => :bold
      text "A dimensão Gestão Escolar Democrática visa fornecer indicadores sobre o grau de participação da comunidade que as escolas vêm conseguindo instituir, como tem se dado a comunicação entre todos, o papel e a atuação dos coletivos escolares e as parcerias e recursos que elas têm conseguido conquistar.", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/infantil/general_average_dimension9-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(9.1 9.2 9.3), "infantil")

      start_new_page
      text "c) Questões problematizadoras:"
      text "1. De acordo com o PME de Osasco, a participação da comunidade é imprescindível, sendo uma forma prática de formação para a cidadania, através da qual a população aprende a intervir no Estado. Nesse sentido, o que os dados obtidos no processo de avaliação nos revelam com relação à inclusão da população nos processos que dizem respeito aos assuntos da educação? A secretaria vem estimulando e criando condições para que as unidades envolvam a população em suas ações desde o início dos processos?", :indent_paragraphs => 30
      text "2. A Secretaria vem estimulando a sua rede a criar mecanismos permanentes de consulta como o CGC e a participação no processo de orçamento participativo?", :indent_paragraphs => 30
      text "3. O que os dados revelam sobre os compromissos assumidos com as diretrizes estabelecidas pelo Plano de Desenvolvimento da Educação (decreto nº 6.094, 24 de abril de 2007), denominadas “Compromisso Todos pela Educação”?", :indent_paragraphs => 30

      start_new_page
      text "3.1.10. Dimensão 10. Formação e Condições de Trabalho dos Profissionais da Escola", :style => :bold
      text "A dimensão Formação e Condições de Trabalho dos Profissionais da Escola visa fornecer indicadores sobre as condições de trabalho implementadas pela escola em relação à formação inicial, à formação continuada, à assiduidade e à estabilidade da equipe que a escola tem conseguido institucionalizar.", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/infantil/general_average_dimension10-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(10.1 10.2 10.3), "infantil")

      start_new_page
      text "c) Questões problematizadoras:"
      text "1. O que os dados revelam sobre os compromissos assumidos com as diretrizes estabelecidas pelo Plano de Desenvolvimento da Educação (decreto nº 6.094, 24 de abril de 2007), denominadas “Compromisso Todos pela Educação”?", :indent_paragraphs => 30
      text "2. O que os dados revelam sobre os objetivos e metas traçados no PME relativos a esta dimensão?", :indent_paragraphs => 30

      text " \n 3.2. Quadro dos índices das unidades, por dimensões: Educação Infantil", :style => :bold

      show_table_with_index_by_unit

      start_new_page(:template => "#{RAILS_ROOT}/public/relatorios/artifacts/EMEI_legend.pdf", :template_page => 1)
      start_new_page(:template => "#{RAILS_ROOT}/public/relatorios/artifacts/EMEI_legend.pdf", :template_page => 2)
      start_new_page(:template => "#{RAILS_ROOT}/public/relatorios/artifacts/EMEI_table.pdf")
      start_new_page(:template => "#{RAILS_ROOT}/public/relatorios/artifacts/creche_legend.pdf")
      start_new_page(:template => "#{RAILS_ROOT}/public/relatorios/artifacts/creche_table.pdf")
      start_new_page

      text "Questões para dialogar:"
      text "1. De acordo com os índices, quais dimensões precisam ser priorizadas no planejamento das ações da Secretaria?", :indent_paragraphs => 30
      text "2. Os índices das unidades mantiveram um padrão para todas as dimensões ou pode-se perceber discrepâncias? Exemplo: uma unidade consegue um índice bastante favorável em uma dimensão e outra já não consegue o mesmo feito. Quais razões contribuíram para esse evento?", :indent_paragraphs => 30
      text "3.Quais as unidades tiveram índices aquém do esperado e em quais dimensões? Quais são os fatores que contribuíram para este resultado?", :indent_paragraphs => 30

      text "\n 3.3. Resultados dos agrupamentos a partir das regiões geográficas, por dimensões", :style => :bold
      text "Há autores que refletem sobre a questão da qualidade nas escolas dizem que, para compreender uma escola, deve-se começar por conhecer sua realidade geográfica. Os recursos humanos e materiais tendem a refletir a localização da escola. Muitas vezes, a localização da escola determina, em última instância, o tipo de aluno que será atendido.", :indent_paragraphs => 30
      text "Nesse sentido, foi analisada a correlação entre os resultados da avaliação por dimensões e por conglomerados de escolas de Educação Infantil por regiões geográficas do município.", :indent_paragraphs => 30
      text "Neste quadro, podemos analisar o resultado da média de cada dimensão por agrupamentos, tendo como referência as regiões geográficas do município. O que podemos observar? Existe alguma correlação entre os resultados obtidos e as escolas localizadas em determinada região? Que elementos podem ter contribuído para este resultado?", :indent_paragraphs => 30

      infantil_group = GeneralReport.get_group_data("infantil")
      image "#{RAILS_ROOT}/public/relatorios/artifacts/table_with_dimensions_and_groups.jpg", :scale => 0.6, :position => :center
      y_positions = [414,394,365,339,306,282,254,218,190,160]
      (0..9).each do |i|
        draw_text "#{infantil_group[:group_1][i+1].round(2)}", :at => [250,y_positions[i]]
        draw_text "#{infantil_group[:group_2][i+1].round(2)}", :at => [335,y_positions[i]]
        draw_text "#{infantil_group[:group_3][i+1].round(2)}", :at => [411,y_positions[i]]
        draw_text "#{infantil_group[:group_4][i+1].round(2)}", :at => [490,y_positions[i]]
      end

      start_new_page
      text "CAPÍTULO IV. RESULTADOS DA AVALIAÇÃO DO PEC-OSASCO 2010 - ENSINO FUNDAMENTAL", :style => :bold

      text " \n 4. Análise dos Resultados do Ensino Fundamental", :style => :bold, :size => 13
      text " \n 4.1. Análise dos dados, por dimensões e indicadores", :style => :bold
      text "A seguir apresentamos os gráficos e mapas dos resultados obtidos, por dimensão. Sugerimos as seguintes questões para todas as dimensões:", :indent_paragraphs => 30
      text "1. A partir da leitura detalhada dos resultados por dimensões, quais indicadores merecem atenção especial?", :indent_paragraphs => 30
      text "2. Há diferenças significativas entre as visões dos segmentos a respeito dos indicadores? Se sim, como podemos interpretar estas diferenças? Que fatores podem ter contribuído para este resultado?", :indent_paragraphs => 30
      text "3. É possível identificar correlação entre as médias apresentadas e a qualidade das ações propostas nos PTAs das unidades?", :indent_paragraphs => 30
      text "4. Existem movimentos organizados pela Secretaria que permitam às unidades compartilharem suas boas práticas relacionadas aos indicadores/dimensão analisada?", :indent_paragraphs => 30
      text "5. Que ações devem partir da Secretaria para que a rede melhore seu desempenho nestes indicadores/dimensão? Qual deve ser o papel dos supervisores nestas ações?", :indent_paragraphs => 30
      text "6. Olhando para as nossas metas, tanto aquelas previstas pelas diretrizes estabelecidas pelo Plano de Desenvolvimento da Educação (decreto nº 6.094, 24 de abril de 2007), denominadas “Compromisso Todos pela Educação” como pelo PME de 2009 e cotejando-as com os resultados da avaliação, por dimensões e indicadores, conseguimos alcançá-las com êxito? Quais não conseguimos e quais serão os nossos esforços para melhorar a educação que oferecemos para as crianças e jovens do município?", :indent_paragraphs => 30

      start_new_page
      text "4.1.1. Dimensão 1. Ambiente Educativo", :style => :bold
      text "O Ambiente Educativo visa fornecer indicadores do ambiente que predomina na escola, das relações entre os diversos segmentos, do grau de conhecimento e participação deles na elaboração dos princípios de convivência e no conhecimento que se tem dos direitos das crianças, tendo em vista sua importância como referência às ações educativas para a escola. A escola é um dos espaços de ensino, aprendizagem e vivência de valores. Nela, os indivíduos se socializam, brincam e experimentam a convivência com a diversidade humana. No ambiente educativo, o respeito, a alegria, a amizade e a solidariedade, a disciplina, a negociação, o combate à discriminação e o exercício dos direitos e deveres são práticas que garantem a socialização e a convivência, desenvolvem e fortalecem a noção de cidadania e de igualdade entre todos.", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/fundamental/general_average_dimension1-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 1.10), "fundamental")

      start_new_page
      text "c) Questões problematizadoras:"
      text "1. Em que medida as ações do CTP podem contribuir para a elaboração dos princípios de convivência da UE com a participação de todos os segmentos?"
      text "2. O conhecimento que as unidades têm sobre o ECA, revelado pela avaliação de 2010, tem sido suficiente? Tem sido referência em todas as ações educativas da UE? O que o CTP pode fazer em relação a isto?"
      text "3. Os resultados revelados pela avaliação de 2010 demonstram que há práticas suficientes nas UEs em relação à socialização e convivência? O que o CTP pode fazer para melhorar essa questão nas unidades?"

      start_new_page
      text "4.1.2. Dimensão 2. Ambiente Físico Escolar e Materiais", :style => :bold
      text "O ambiente físico escolar está diretamente relacionado à qualidade social da educação. Este deve ser atrativo, organizado, limpo, arejado, agradável, com árvores e plantas. Deve ainda dispor de móveis, equipamentos e materiais didáticos acessíveis, adequados à realidade da escola e que permitam a prestação de serviços de qualidade aos alunos, aos pais e a toda comunidade.", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/fundamental/general_average_dimension2-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(2.1 2.2 2.3 2.4), "fundamental")

      start_new_page
      text "c) Questões problematizadoras:"
      text "1. O que os resultados revelam sobre a percepção dos segmentos acerca desta dimensão e seus indicadores? Quais fatores podem influenciar estas percepções?"
      text "2. É possível formular hipóteses sobre a forma como o subsídio recebido pelas unidades tem sido utilizado? As unidades têm investido em melhorias? É possível observar alguma tendência na priorização de determinados itens? É possível avaliar se o subsídio tem sido suficiente ou bem gerido?"
      text "3. As iniciativas da Secretaria relacionadas à troca de mobília ou envio de materiais como livros e outros tiveram reflexo nas médias apresentadas?"
      text "4. As unidades em que foram realizadas reformas tiveram uma boa avaliação nesta dimensão? O que as médias revelam sobre a possibilidade de participação ativa dos segmentos na tomada de decisões no processo de reforma?"
      text "5. O que os resultados revelam acerca da implantação da RECEI e RECEF nas unidades? Os resultados revelam que as unidades estão dedicadas a relacionar espaço físico e aprendizagem? "
      text "6. O espaço físico e materiais contemplam as necessidades dos diferentes segmentos? Que responsabilidades e ações devem partir da Secretaria para que a rede melhore seu desempenho nestes indicadores/dimensão? Qual deve ser o papel dos supervisores nestas ações?"
      text "7. O que os dados revelam sobre os objetivos e metas traçados no PME relativos a esta dimensão?"

      start_new_page
      text "4.1.3. Dimensão 3. Planejamento Institucional e Prática Pedagógica", :style => :bold
      text "Essa dimensão visa fornecer indicadores sobre o processo fundamental da escola, que é o de fazer com que os educandos aprendam e adquiram o desejo de aprender cada vez mais e com autonomia. Construção de uma proposta pedagógica bem definida e a necessidade de um planejamento com base em conhecimentos sobre o que os educandos já possuem e o que eles precisam e desejam saber são indicadores fundamentais de uma prática pedagógica centrada no desenvolvimento dos educandos.", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/fundamental/general_average_dimension3-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8), "fundamental")

      start_new_page
      text "c) Questões problematizadoras:"
      text "1. O que os resultados revelam acerca da implantação da RECEI e RECEF nas unidades? As ações promovidas pela Secretaria, como formações e encontros, estão refletindo mudanças significativas?"
      text "2. O que os dados revelam sobre a participação e compreensão dos segmentos acerca do Projeto Eco-Político-Pedagógico? Ele vem sendo construído coletivamente? Que ações devem ser encabeçadas pela Secretaria para que isto seja assegurado?"
      text "3. O que os dados revelam sobre os compromissos assumidos com as diretrizes estabelecidas pelo Plano de Desenvolvimento da Educação (decreto nº 6.094, 24 de abril de 2007), denominadas “Compromisso Todos pela Educação”?"
      text "4. O que os dados revelam sobre os objetivos e metas traçados no PME relativos a esta dimensão?"

      start_new_page
      text "4.1.4. Dimensão 4. Avaliação", :style => :bold
      text "Essa dimensão visa fornecer os indicadores que dizem respeito à prática da avaliação como parte integrante e fundamental do processo educativo. Monitoramento do processo de aprendizagem, mecanismos e variedades de avaliação, participação dos educandos no processo de avaliação da aprendizagem; autoavaliação; avaliação dos profissionais e da escola como um todo; discussão e reflexão sobre as avaliações externas implementadas pelo MEC são indicadores fundamentais que apontam se a escola vem construindo a cultura da avaliação, pressuposto fundamental para o desenvolvimento de uma educação de qualidade, que garanta o direito de aprender.", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/fundamental/general_average_dimension4-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(4.1 4.2 4.3 4.4 4.5), "fundamental")
      start_new_page
      text "c) Questões problematizadoras:"
      text "1. O que os dados revelam sobre a cultura de avaliação nas unidades?"
      text "2. Os dados sobre a avaliação dos educandos estão coerentes com a proposta da RECEI e RECEF? Que ações devem ser propostas pela Secretaria para assegurar esta coerência?"
      text "3. Os dados revelam uma cultura de avaliação dos profissionais das escolas? Que ações a Secretaria pode propor a fim de promover/fomentar esta cultura? Que papel os supervisores devem exercer neste processo?"
      text "4. As escolas estão utilizando os indicadores e dados das avaliações oficiais no seu dia a dia? Que ações a Secretaria de Educação propõe para que estes dados sejam atualizados, conhecidos e utilizados por todos? Em que medida a política educacional do município é pautada por estes dados e indicadores?"
      text "5. O que os dados revelam sobre os compromissos assumidos com as diretrizes estabelecidas pelo Plano de Desenvolvimento da Educação (decreto nº 6.094, 24 de abril de 2007), denominadas “Compromisso Todos pela Educação”?"

      start_new_page
      text "4.1.5 Dimensão 5. Acesso e Permanência dos Educandos na Escola", :style => :bold
      text "Esta dimensão visa fornecer indicadores sobre como a escola tem tratado a questão da democratização do acesso do aluno à instituição educativa, das faltas, da evasão e do abandono e dos esforços que a escola vem promovendo, para fazer com que os educandos que evadiram ou abandonaram voltem para a escola. O acesso, ou seja, a matrícula, é a porta inicial para a democratização, mas torna-se necessário, também, garantir o direito de todos os que ingressam na  escola a condições de nela permanecer com sucesso (ou seja, permanecer e “aprender” na escola), sem interrupções até o término de um ciclo. Essa dimensão trata ainda da identificação dos indicadores referentes às necessidades educativas das respectivas comunidades.", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/fundamental/general_average_dimension5-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(5.1 5.2 5.3 5.4), "fundamental")

      start_new_page
      text "c) Questões problematizadoras:"
      text "1. Que ações o município desenvolve para garantir o acesso e permanência dos educandos na escola? Como estas políticas podem ser avaliadas, tendo como base as médias obtidas nos diversos segmentos?"
      text "2. Os dados revelam ações no sentido de atender às necessidades educativas da comunidade? Que fatores podem influenciar a existência / inexistência destas ações?"
      text "3. Que ações o município tem realizado no sentido de garantir que os profissionais estejam bem preparados para atender aos alunos com alguma defasagem de aprendizagem? De acordo com os resultados, é possível afirmar que estes esforços têm gerado os impactos desejados?"
      text "4. Que ações o município tem realizado no sentido de minimizar os casos de evasão e abandono nas unidades? De acordo com os resultados, é possível afirmar que estes esforços têm gerado os impactos desejados?"
      text "5. O que os dados revelam sobre os compromissos assumidos com as diretrizes estabelecidas pelo Plano de Desenvolvimento da Educação (decreto nº 6.094, 24 de abril de 2007), denominadas “Compromisso Todos pela Educação”?"
      text "6. O que os dados revelam sobre os objetivos e metas traçados no PME relativos a esta dimensão?"

      start_new_page
      text "4.1.6. Dimensão 6. Promoção da Saúde", :style => :bold
      text "A dimensão Promoção da Saúde se relaciona com os indicadores que dizem respeito às práticas cotidianas e os cuidados que a instituição tem com relação à saúde das crianças e dos adultos da escola. A atenção à saúde das crianças é um aspecto muito importante do trabalho em instituições de educação. As práticas cotidianas precisam assegurar a prevenção de acidentes, os cuidados com a higiene e uma alimentação saudável, para o bom desenvolvimento das crianças em idade de crescimento.", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/fundamental/general_average_dimension6-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(6.1 6.2 6.3 6.4), "fundamental")

      start_new_page
      text "c) Questões problematizadoras:"
      text "1. Que ações a Secretaria da Educação desenvolve estão diretamente ligadas à promoção da saúde? Estas ações estão sendo eficazes e efetivas? Que novas ações precisam ser desenvolvidas para que estes resultados sejam melhorados?"
      text "2. As parcerias da Secretaria da Educação com outras secretarias (como saúde e abastecimento) e organizações estão se desenvolvendo de forma adequada? Como os dados revelam isso? É preciso buscar novas parcerias?"
      text "3. A Secretaria tem conhecimento do perfil epidemiológico de seus alunos e alunas para melhorar direcionar as políticas públicas voltadas para a promoção da saúde?"
      text "4. O que os dados revelam sobre os compromissos assumidos com as diretrizes estabelecidas pelo Plano de Desenvolvimento da Educação (decreto nº 6.094, 24 de abril de 2007), denominadas “Compromisso Todos pela Educação”?"

      start_new_page
      text "4.1.7. Dimensão 7. Educação Socioambiental e Práticas Ecopedagógicas", :style => :bold
      text "A dimensão Educação Socioambiental e Práticas Ecopedagógicas visa fornecer indicadores sobre a formação em torno dos temas da cidadania planetária e as práticas educativas que garantem o conhecimento da realidade e a participação na construção de uma sociedade sustentável, com fundamentos da ecopedagogia.", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/fundamental/general_average_dimension7-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(7.1 7.2), "fundamental")

      start_new_page
      text "c) Questões problematizadoras:"
      text "1. Os resultados das avaliações das unidades revelam suficiência nas formações em torno dos temas da cidadania planetária e da sustentabilidade?"
      text "2. O que o CTP pode planejar para incentivar práticas educativas que garantam o conhecimento da realidade e a participação de toda comunidade escolar na construção de uma sociedade sustentável? "
      text "3. Tendo em vista que um dos princípios e objetivos do sistema municipal de educação de Osasco é o compromisso com a promoção e o incentivo à cultura da educação ambiental, nas instituições públicas e privadas, pró-recuperação e conservação dos recursos naturais, do desenvolvimento sustentável e da paz, como a rede educacional lida com a questão socioambiental? Temos conseguido desenvolver uma educação socioambiental e práticas ecopedagógicas consistentes?"

      start_new_page
      text "4.1.8. Dimensão 8. Envolvimento com as Famílias e Participação na Rede de Proteção Social", :style => :bold
      text "A dimensão Envolvimento com as Famílias e Participação na Rede de Proteção Social visa fornecer os indicadores que apontam se as famílias vêm sendo acolhidas pela Escola e em que medida a escola vem garantido o direito das famílias em acompanhar as vivências e produções das crianças. Essa dimensão visa ainda fornecer os indicadores que apontam em que medida se dá a articulação da Escola com a Rede de Proteção aos Direitos das Crianças, pois a instituição escolar é responsável, juntamente com as famílias, por garantir os direitos das crianças. Também visa refletir como os demais serviços públicos de alguma forma estão contribuindo para que todas as crianças sejam, de fato, sujeitos de direitos, conforme preconiza o Estatuto da Criança e do Adolescente (ECA).", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/fundamental/general_average_dimension8-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(8.1 8.2 8.3), "fundamental")

      start_new_page
      text "c) Questões problematizadoras:"
      text "1. Quanto maior e mais positiva for a interação entre a escola e os familiares e a comunidade a que ela atende, maior é a probabilidade de a escola oferecer aos seus educandos um ensino de qualidade. Diante dessa afirmação, como estamos promovendo a cooperação e o envolvimento com as famílias de nossa comunidade? A as unidades da rede municipal procuram conhecer e trocar experiências  com as famílias e com a comunidade?"
      text "2. A rede municipal tem propiciado às unidades momentos que  favoreçam  vínculos positivos de parceria com os familiares dos educandos? Quais? De que forma eles são percebidos pelos diferentes segmentos e de que forma impactam no aprendizado e interesse e prazer da criança pelos estudos?"
      text "3. A Secretaria  busca mapear e identificar os equipamentos sociais  que existem no município  que possam  contribuir para a constituição de uma rede de proteção social dos direitos das crianças? Como estas informações são divulgadas para as unidades? Como estas informações são divulgadas pelas unidades para a comunidade escolar?"
      text "4. A Secretaria estimula que as unidades articulem  estreito relacionamento com  a Rede de Proteção aos direitos das crianças existentes em seu entorno?"
      text "5. A Secretaria estimula e propicia momentos em  que os profissionais da educação se atualizem no tocante à observação dos educandos com possíveis sinais de negligência e violência física e psicológica?"
      text "6. A Secretaria estimula as unidades criarem  procedimentos de proteção  ao constatarem sinais de violência e desrespeito à integridade das crianças?"
      text "7. O que os dados revelam sobre os compromissos assumidos com as diretrizes estabelecidas pelo Plano de Desenvolvimento da Educação (decreto nº 6.094, 24 de abril de 2007), denominadas “Compromisso Todos pela Educação”?"
      text "8. O que os dados revelam sobre os objetivos e metas traçados no PME relativos a esta dimensão?"

      start_new_page
      text "4.1.9. Dimensão 9. Gestão Escolar Democrática", :style => :bold
      text "A dimensão Gestão Escolar Democrática visa fornecer indicadores sobre o grau de participação da comunidade que as escolas vêm conseguindo instituir, como tem se dado a comunicação entre todos, o papel e a atuação dos coletivos escolares e as parcerias e recursos que elas têm conseguido conquistar.", :indent_paragraphs => 30

      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/fundamental/general_average_dimension9-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(9.1 9.2 9.3 9.4), "fundamental")

      start_new_page
      text "c) Questões problematizadoras:"
      text "1. De acordo com o PME de Osasco, a participação da comunidade é imprescindível sendo uma forma prática de formação para a cidadania, através da qual a população aprende a intervir no Estado. Nesse sentido, o que os dados  obtidos no processo de avaliação nos revelam com relação à inclusão da população nos processos que dizem respeito aos assuntos da educação? A Secretaria vem  estimulando e criando condições para que as unidades envolvam a população em suas ações desde o início dos processos?"
      text "2. A Secretaria vem estimulando a sua rede a criar mecanismos permanentes de consulta como o CGC e a participação no processo de orçamento participativo?"
      text "3. O que os dados revelam sobre os compromissos assumidos com as diretrizes estabelecidas pelo Plano de Desenvolvimento da Educação (decreto nº 6.094, 24 de abril de 2007), denominadas “Compromisso Todos pela Educação”?"

      start_new_page
      text "4.1.10. Dimensão 10. Formação e Condições de Trabalho dos Profissionais da Escola", :style => :bold
      text "A dimensão Formação e Condições de Trabalho dos Profissionais da Escola visa fornecer indicadores sobre as condições de trabalho implementadas pela escola em relação à formação inicial, à formação continuada, à assiduidade e à estabilidade da equipe que a escola tem conseguido institucionalizar.", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/fundamental/general_average_dimension10-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(10.1 10.2 10.3), "fundamental")

      start_new_page
      text "c) Questões problematizadoras:"


      text "1. O que os dados revelam sobre os compromissos assumidos com as diretrizes estabelecidas pelo Plano de Desenvolvimento da Educação (decreto nº 6.094, 24 de abril de 2007), denominadas “Compromisso Todos pela Educação”?"
      text "2. O que os dados revelam sobre os objetivos e metas traçados no PME relativos a esta dimensão?"

      start_new_page
      text "4.1.11. Dimensão  11.Processos de Alfabetização e Letramento", :style => :bold
      text "Essa dimensão diz respeito aos indicadores referentes a todos os aspectos que, no conjunto, favorecem a alfabetização inicial e a ampliação da capacidade da leitura e escrita de todas as crianças e adolescentes ao longo do Ensino Fundamental.  O domínio da leitura e da escrita é condição para o bom desenvolvimento de outros conteúdos escolares e, também, para que, depois de concluída a educação básica, o cidadão ea cidadã possam continuar aprendendo e se desenvolvendo com autonomia.", :indent_paragraphs => 30
      text " \na) gráfico geral da rede sobre a dimensão \n"
      image "#{RAILS_ROOT}/public/relatorios/artifacts/graphs/fundamental/general_average_dimension11-graph.jpg", :scale => 1, :position => :center

      start_new_page
      text "b) Gráficos gerais das percepções da rede sobre os indicadores"
      insert_graphics(%w(11.1 11.2 11.3 11.4 11.5), "fundamental")

      start_new_page
      text "c) Questões problematizadoras:"
      text "1. O que os dados revelam sobre os compromissos assumidos com as diretrizes estabelecidas pelo Plano de Desenvolvimento da Educação (decreto nº 6.094, 24 de abril de 2007), denominadas “Compromisso Todos pela Educação”?"
      text "2. O que os dados revelam sobre os objetivos e metas traçados no PME relativos a esta dimensão?"
      text "3. Que ações, por parte da Secretaria, podem ser previstas para que em 2011 as escolas da Rede  se envolvam cada vez mais  no exercício da função social da escrita pela criança?"
      text "4. Que ações podem ser previstas para que os educandos e membros da comunidade tenham acesso e possam emprestar os livros e demais textos disponíveis na escola?"

      text " \n4.2. Quadro dos índices das unidades, por dimensões: Ensino Fundamental", :style => :bold

      show_table_with_index_by_unit

      start_new_page(:template => "#{RAILS_ROOT}/public/relatorios/artifacts/EMEF_legend.pdf", :template_page => 1)
      start_new_page(:template => "#{RAILS_ROOT}/public/relatorios/artifacts/EMEF_legend.pdf", :template_page => 2)
      start_new_page(:template => "#{RAILS_ROOT}/public/relatorios/artifacts/EMEF_table.pdf", :template_page => 1)
      start_new_page

      text "Questões para dialogar:"
      text "1. De acordo com os índices, quais dimensões precisam ser priorizadas no planejamento das ações da Secretaria?"
      text "2. Os índices das unidades mantiveram um padrão para todas as dimensões ou  pode-se perceber discrepâncias? Exemplo: uma unidade consegue um índice bastante favorável em uma dimensão e outra já não consegue o mesmo feito. Quais razões contribuíram para esse evento?"
      text "3. Quais as unidades tiveram índices aquém do esperado e em quais dimensões? Quais são os fatores que contribuíram para este resultado?"

      text " \n 4.3. Resultados dos agrupamentos a partir dos estratos do IDEB, por dimensões: Ensino Fundamental", :style => :bold
      text "Neste quadro, podemos analisar o resultado da média de cada dimensão por agrupamento,  tendo como referência  os estratos de escolas do IDEB. A partir dele, o que podemos observar?   Que elementos podem ter contribuído para este resultado em cada estrato? De que forma os indicadores favoreceram este resultado?
        Olhando para as unidades que compõem os agrupamentos, podemos observar alguns padrões entre elas que contribuiu para o desempenho no IDEB? Quais são esses padrões?", :indent_paragraphs => 30
      text "É possível afirmar que o grupo de escolas que conseguiu médias melhores nas dimensões também conseguiu uma pontuação favorável no IDEB? Existe correlação entre esses resultados?", :indent_paragraphs => 30

      fundamental_group = GeneralReport.get_group_data("fundamental")
      image "#{RAILS_ROOT}/public/relatorios/artifacts/table_with_dimensions_and_groups_fundamental.jpg", :scale => 0.6, :position => :center
      y_positions = [445,426,406,379,348,320,292,257,231,203,170]
      (0..10).each do |i|
        draw_text "#{fundamental_group[:group_1][i+1].round(2)}", :at => [252,y_positions[i]]
        draw_text "#{fundamental_group[:group_2][i+1].round(2)}", :at => [323,y_positions[i]]
        draw_text "#{fundamental_group[:group_3][i+1].round(2)}", :at => [392,y_positions[i]]
        draw_text "#{fundamental_group[:group_4][i+1].round(2)}", :at => [463,y_positions[i]]
      end

      start_new_page
      text "CAPÍTULO V. META-AVALIAÇÃO", :style => :bold
      text " \na) Mobilização"
      text "b) Participação"
      text "c) Metodologia"
      text "d) Condições Físicas e Materiais"
      text "e) Período de Aplicação e Inserção dos dados no on-line"
      text "f) Análise Coletiva"

      start_new_page
      text "CAPÍTULO VI. CONSIDERAÇÕES FINAIS", :style => :bold
      draw_text "116", :at => [(bounds.left + bounds.right), 1, 2], :size => 14, :style => :italic
      number_pages "<page>",[(bounds.left + bounds.right), 1, 2]
    end
  end

private

  def self.calc_media_by_group_and_service_level(dimension, service_level)
    case service_level.name
      when "EMEF"
        group_names = ['EF-Grupo 1', 'EF-Grupo 2', 'EF-Grupo 3', 'EF-Grupo 4']
      when "EMEI"
        group_names = ['EI-Grupo 1', 'EI-Grupo 2', 'EI-Grupo 3', 'EI-Grupo 4']
      when "Creche"
        group_names = ['C-Grupo 1', 'C-Grupo 2', 'C-Grupo 3', 'C-Grupo 4']
    end
    group_medias = []
    group_names.each do |group|
      group = Group.first(:conditions => "name = '#{group}'")
      group_medias << Institution.mean_dimension_by_group(dimension, service_level, group)[:mean]
    end
    group_medias
  end

end

