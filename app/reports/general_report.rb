require "open-uri"

class GeneralReport
# estilos
  STYLES = {
             :titulo => {  :align => :center, :style => :bold, :size => 16 },
             :chapitulo => { :align => :left, :style => :bold, :size => 14 },
             :secao => { :align => :left, :size => 13 },
             :texto =>  { :size => 11, :indent_paragraphs => 40, :style => :normal },
             :centro => { :align => :center }
           }

  def to_pdf(ue,answers,service_level) 
    Prawn::Document.generate("#{RAILS_ROOT}/public/relatorios/#{ue.name}_#{service_level.name}.pdf") do
#  def bold_cell(text)
#    { :text => text, :style => :bold }
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
  image header, :at => [0,770], :scale => 0.75
  image footer, :at => [350,50], :scale => 0.75
end


##########################################################################################
  fill_color "000000"

  text "\n Percepção da UE sobre a Dimensão 1", :style => :bold
 #     image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d1.png"
  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
 #   image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d1i1.png", :position => :left 
 #   image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d1i2.png"
 #   image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d1i3.png", :position => :left 
 #   image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d1i4.png"
 #   image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d1i5.png", :position => :left 

 # answers111 = ue.mean_question("1.1.1",service_level)
 # answers112 = ue.mean_question("1.1.2",service_level)
 # answers121 = ue.mean_question("1.2.1",service_level)
 # answers122 = ue.mean_question("1.2.2",service_level)
 # answers123 = ue.mean_question("1.2.3",service_level)
 # answers131 = ue.mean_question("1.3.1",service_level)
 # answers132 = ue.mean_question("1.3.2",service_level)
 # answers133 = ue.mean_question("1.3.3",service_level)
 # answers141 = ue.mean_question("1.4.1",service_level)
 # answers142 = ue.mean_question("1.4.2",service_level)
 # answers143 = ue.mean_question("1.4.3",service_level)
 # answers151 = ue.mean_question("1.5.1",service_level)
 # answers152 = ue.mean_question("1.5.2",service_level)
 # answers153 = ue.mean_question("1.5.3",service_level)
 # answers154 = ue.mean_question("1.5.4",service_level)
 # answers161 = ue.mean_question("1.6.1",service_level)
 # answers162 = ue.mean_question("1.6.2",service_level)
 # answers171 = ue.mean_question("1.7.1",service_level)
 # answers172 = ue.mean_question("1.7.2",service_level)
 # answers181 = ue.mean_question("1.8.1",service_level)
 # answers182 = ue.mean_question("1.8.2",service_level)
 # answers183 = ue.mean_question("1.8.3",service_level)
 # answers191 = ue.mean_question("1.9.1",service_level)
 # answers192 = ue.mean_question("1.9.2",service_level)
 # answers1101 = ue.mean_question("1.10.1",service_level)
 # answers1102 = ue.mean_question("1.10.2",service_level)
  
  
  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar"

 #table3 = [["resposta","professores","gestores","educandos","func. de apoio","familiares"],["1.1.1","#{answers111['professores']}","#{answers111['gestores']}","#{answers111['educandos']} ","#{answers111['funcionarios']}","#{answers111['familiares']}"],["1.1.2","#{answers112['professores']}","#{answers112['gestores']}","#{answers112['educandos']} ","#{answers112['funcionarios']}","#{answers112['familiares']}"],["1.2.1","#{answers121['professores']}","#{answers121['gestores']}","#{answers121['educandos']} ","#{answers121['funcionarios']}","#{answers121['familiares']}"],["1.2.2","#{answers122['professores']}","#{answers122['gestores']}","#{answers122['educandos']} ","#{answers122['funcionarios']}","#{answers122['familiares']}"],["1.2.3","#{answers123['professores']}","#{answers123['gestores']}","#{answers123['educandos']} ","#{answers123['funcionarios']}","#{answers123['familiares']}"],["1.3.1","#{answers131['professores']}","#{answers131['gestores']}","#{answers131['educandos']} ","#{answers131['funcionarios']}","#{answers131['familiares']}"],["1.3.2","#{answers132['professores']}","#{answers132['gestores']}","#{answers132['educandos']} ","#{answers132['funcionarios']}","#{answers132['familiares']}"],["1.3.3","#{answers133['professores']}","#{answers133['gestores']}","#{answers133['educandos']} ","#{answers133['funcionarios']}","#{answers133['familiares']}"],["1.4.1","#{answers141['professores']}","#{answers141['gestores']}","#{answers141['educandos']} ","#{answers141['funcionarios']}","#{answers141['familiares']}"],["1.4.2","#{answers142['professores']}","#{answers142['gestores']}","#{answers142['educandos']} ","#{answers142['funcionarios']}","#{answers142['familiares']}"],["1.4.3","#{answers143['professores']}","#{answers143['gestores']}","#{answers143['educandos']} ","#{answers143['funcionarios']}","#{answers143['familiares']}"],["1.5.1","#{answers151['professores']}","#{answers151['gestores']}","#{answers151['educandos']} ","#{answers151['funcionarios']}","#{answers151['familiares']}"],["1.5.2","#{answers152['professores']}","#{answers152['gestores']}","#{answers152['educandos']} ","#{answers152['funcionarios']}","#{answers152['familiares']}"],["1.5.3","#{answers153['professores']}","#{answers153['gestores']}","#{answers153['educandos']} ","#{answers153['funcionarios']}","#{answers153['familiares']}"],["1.5.4","#{answers154['professores']}","#{answers154['gestores']}","#{answers154['educandos']} ","#{answers154['funcionarios']}","#{answers154['familiares']}"],["1.6.1","#{answers161['professores']}","#{answers161['gestores']}","#{answers161['educandos']} ","#{answers161['funcionarios']}","#{answers161['familiares']}"],["1.6.2","#{answers162['professores']}","#{answers162['gestores']}","#{answers162['educandos']} ","#{answers162['funcionarios']}","#{answers162['familiares']}"],["1.7.1","#{answers171['professores']}","#{answers171['gestores']}","#{answers171['educandos']} ","#{answers171['funcionarios']}","#{answers171['familiares']}"],["1.7.2","#{answers172['professores']}","#{answers172['gestores']}","#{answers172['educandos']} ","#{answers172['funcionarios']}","#{answers172['familiares']}"],["1.8.1","#{answers181['professores']}","#{answers181['gestores']}","#{answers181['educandos']} ","#{answers181['funcionarios']}","#{answers181['familiares']}"],["1.8.2","#{answers182['professores']}","#{answers182['gestores']}","#{answers182['educandos']} ","#{answers182['funcionarios']}","#{answers182['familiares']}"],["1.8.3","#{answers183['professores']}","#{answers183['gestores']}","#{answers183['educandos']} ","#{answers183['funcionarios']}","#{answers183['familiares']}"],["1.9.1","#{answers191['professores']}","#{answers191['gestores']}","#{answers191['educandos']} ","#{answers191['funcionarios']}","#{answers191['familiares']}"],["1.9.2","#{answers192['professores']}","#{answers192['gestores']}","#{answers192['educandos']} ","#{answers192['funcionarios']}","#{answers192['familiares']}"],["1.10.1","#{answers1101['professores']}","#{answers1101['gestores']}","#{answers1101['educandos']} ","#{answers1101['funcionarios']}","#{answers1101['familiares']}"],["1.10.2","#{answers1102['professores']}","#{answers1102['gestores']}","#{answers1102['educandos']} ","#{answers1102['funcionarios']}","#{answers1102['familiares']}"]] 

#  table table3

  start_new_page

  text "\n Percepção da UE sobre a Dimensão 2", :style => :bold
  #  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d2.png"
  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
  #  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d2i1.png", :position => :left 
  #  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d2i2.png"
  #  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d2i3.png", :position => :left 

 # answers211 = ue.mean_question("2.1.1",service_level)
 # answers212 = ue.mean_question("2.1.2",service_level)
 # answers213 = ue.mean_question("2.1.3",service_level)
 # answers214 = ue.mean_question("2.1.4",service_level)
 # answers221 = ue.mean_question("2.2.1",service_level)
 # answers222 = ue.mean_question("2.2.2",service_level)
 # answers231 = ue.mean_question("2.3.1",service_level)
 # answers232 = ue.mean_question("2.3.2",service_level)
 # answers233 = ue.mean_question("2.3.3",service_level)
 # answers234 = ue.mean_question("2.3.4",service_level)

  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar"
 # table5 = [["Resposta","Professores","Gestores","Educandos","Func. de Apoio","Familiares"],["2.1.1""#{answers211['Professores']}","#{answers211['Gestores']}","#{answers211['Educandos']}","#{answers211['Funcionarios']}","#{answers211['Familiares']}"],["2.1.2","#{answers212['Professores']}","#{answers212['Gestores']}","#{answers212['Educandos']}","#{answers212['Funcionarios']}","#{answers212['Familiares']}"],["2.1.3","#{answers213['Professores']}","#{answers213['Gestores']}","#{answers213['Educandos']}","#{answers213['Funcionarios']}","#{answers213['Familiares']}"],["2.1.4","#{answers214['Professores']}","#{answers214['Gestores']}","#{answers214['Educandos']}","#{answers214['Funcionarios']}","#{answers214['Familiares']}"],["2.2.1","#{answers221['Professores']}","#{answers221['Gestores']}","#{answers221['Educandos']}","#{answers221['Funcionarios']}","#{answers221['Familiares']}"],["2.2.2","#{answers222['Professores']}","#{answers222['Gestores']}","#{answers222['Educandos']}","#{answers222['Funcionarios']}","#{answers222['Familiares']}"],["2.3.1","#{answers231['Professores']}","#{answers231['Gestores']}","#{answers231['Educandos']}","#{answers231['Funcionarios']}","#{answers231['Familiares']}"],["2.3.2","#{answers232['Professores']}","#{answers232['Gestores']}","#{answers232['Educandos']}","#{answers232['Funcionarios']}","#{answers232['Familiares']}"],["2.3.3","#{answers233['Professores']}","#{answers233['Gestores']}","#{answers233['Educandos']}","#{answers233['Funcionarios']}","#{answers233['Familiares']}"],["2.3.4","#{answers234['Professores']}","#{answers234['Gestores']}","#{answers234['Educandos']}","#{answers234['Funcionarios']}","#{answers234['Familiares']}"] ]
 # table table5

  start_new_page

  fill_color "000000"

  text "\n Percepção da UE sobre a Dimensão 3", :style => :bold
#    image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d3.png"
  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
#    image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d3i1.png", :position => :left 

 # answers311 = ue.mean_question("3.1.1",service_level)
 # answers312 = ue.mean_question("3.1.2",service_level)
 # answers313 = ue.mean_question("3.1.3",service_level)
 # answers314 = ue.mean_question("3.1.4",service_level)
 # answers315 = ue.mean_question("3.1.5",service_level)
 # answers316 = ue.mean_question("3.1.6",service_level)
 # answers317 = ue.mean_question("3.1.7",service_level)
 # answers318 = ue.mean_question("3.1.8",service_level)

  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar"
  #table7 = [["Resposta","Professores","Gestores","Educandos","Func. de Apoio","Familiares"],["3.1.1","#{answers311['Professores']}","#{answers311['Gestores']}","#{answers311['Educandos']}","#{answers311['Funcionarios']}","#{answers311['Familiares']}"],["3.1.2","#{answers312['Professores']}","#{answers312['Gestores']}","#{answers312['Educandos']}","#{answers312['Funcionarios']}","#{answers312['Familiares']}"],["3.1.3","#{answers313['Professores']}","#{answers313['Gestores']}","#{answers313['Educandos']}","#{answers313['Funcionarios']}","#{answers313['Familiares']}"],["3.1.4","#{answers314['Professores']}","#{answers314['Gestores']}","#{answers314['Educandos']}","#{answers314['Funcionarios']}","#{answers314['Familiares']}"],["3.1.5","#{answers315['Professores']}","#{answers315['Gestores']}","#{answers315['Educandos']}","#{answers315['Funcionarios']}","#{answers315['Familiares']}"],["3.1.6","#{answers316['Professores']}","#{answers316['Gestores']}","#{answers316['Educandos']}","#{answers316['Funcionarios']}","#{answers316['Familiares']}"],["3.1.7","#{answers317['Professores']}","#{answers317['Gestores']}","#{answers317['Educandos']}","#{answers317['Funcionarios']}","#{answers317['Familiares']}"],["3.1.8","#{answers318['Professores']}","#{answers318['Gestores']}","#{answers318['Educandos']}","#{answers318['Funcionarios']}","#{answers318['Familiares']}"]]
  #table table7
  start_new_page


  fill_color "000000"

  text "\n Percepção da UE sobre a Dimensão 4", :style => :bold
#    image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d4.png"
  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
#    image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d4i1.png", :position => :left 

 # answers411 = ue.mean_question("4.1.1",service_level)
 # answers412 = ue.mean_question("4.1.2",service_level)
 # answers413 = ue.mean_question("4.1.3",service_level)
 # answers414 = ue.mean_question("4.1.4",service_level)

  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar"
#  table9 = [["Resposta","Professores","Gestores","Educandos","Func. de Apoio","Familiares"],["4.1.1","#{answers411['Professores']}","#{answers411['Gestores']}","#{answers411['Educandos']}","#{answers411['Funcionarios']}","#{answers411['Familiares']}"],["4.1.2","#{answers412['Professores']}","#{answers412['Gestores']}","#{answers412['Educandos']}","#{answers412['Funcionarios']}","#{answers412['Familiares']}"],["4.1.3","#{answers413['Professores']}","#{answers413['Gestores']}","#{answers413['Educandos']}","#{answers413['Funcionarios']}","#{answers413['Familiares']}"],["4.1.4","#{answers414['Professores']}","#{answers414['Gestores']}","#{answers414['Educandos']}","#{answers414['Funcionarios']}","#{answers414['Familiares']}"]]
#  table table9
  
  start_new_page
  fill_color "000000"

  text "\n Percepção da UE sobre a Dimensão 5", :style => :bold
# image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d5.png"
  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
# image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d5i1.png", :position => :left 
# image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d5i2.png", :position => :left 
# image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d5i3.png", :position => :left 

 # answers512 = ue.mean_question("5.1.2",service_level)
 # answers522 = ue.mean_question("5.2.2",service_level)
 # answers523 = ue.mean_question("5.2.3",service_level)
 # answers531 = ue.mean_question("5.3.1",service_level)

  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar"
 # table11 = [["Resposta","Professores","Gestores","Educandos","Func. de Apoio","Familiares"],["5.1.2","#{answers512['Professores']}","#{answers512['Gestores']}","#{answers512['Educandos']}","#{answers512['Funcionarios']}","#{answers512['Familiares']}"],["5.2.2","#{answers522['Professores']}","#{answers522['Gestores']}","#{answers522['Educandos']}","#{answers522['Funcionarios']}","#{answers522['Familiares']}"],["5.2.3","#{answers523['Professores']}","#{answers523['Gestores']}","#{answers523['Educandos']}","#{answers523['Funcionarios']}","#{answers523['Familiares']}"],["5.3.1","#{answers531['Professores']}","#{answers531['Gestores']}","#{answers531['Educandos']}","#{answers531['Funcionarios']}","#{answers531['Familiares']}"]]
#  table table11

  start_new_page

  fill_color "000000"

  text "\n Percepção da UE sobre a Dimensão 6", :style => :bold
#    image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d6.png"
  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
#    image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d6i1.png", :position => :left 
#    image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d6i2.png"
#    image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d6i3.png", :position => :left 

 # answers611 = ue.mean_question("6.1.1",service_level)
 # answers612 = ue.mean_question("6.1.2",service_level)
 # answers621 = ue.mean_question("6.2.1",service_level)
 # answers622 = ue.mean_question("6.2.2",service_level)
 # answers623 = ue.mean_question("6.2.3",service_level)
 # answers631 = ue.mean_question("6.3.1",service_level)
 # answers632 = ue.mean_question("6.3.2",service_level)

  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar"
 # table13 = [["Resposta","Professores","Gestores","Educandos","Func. de Apoio","Familiares"],["6.1.1","#{answers611['Professores']}","#{answers611['Gestores']}","#{answers611['Educandos']}","#{answers611['Funcionarios']}","#{answers611['Familiares']}"],["6.1.2","#{answers612['Professores']}","#{answers612['Gestores']}","#{answers612['Educandos']}","#{answers612['Funcionarios']}","#{answers612['Familiares']}"],["6.2.1","#{answers621['Professores']}","#{answers621['Gestores']}","#{answers621['Educandos']}","#{answers621['Funcionarios']}","#{answers621['Familiares']}"],["6.2.2","#{answers622['Professores']}","#{answers622['Gestores']}","#{answers622['Educandos']}","#{answers622['Funcionarios']}","#{answers622['Familiares']}"],["6.2.3","#{answers623['Professores']}","#{answers623['Gestores']}","#{answers623['Educandos']}","#{answers623['Funcionarios']}","#{answers623['Familiares']}"],["6.3.1","#{answers631['Professores']}","#{answers631['Gestores']}","#{answers631['Educandos']}","#{answers631['Funcionarios']}","#{answers631['Familiares']}"],["6.3.2","#{answers632['Professores']}","#{answers632['Gestores']}","#{answers632['Educandos']}","#{answers632['Funcionarios']}","#{answers632['Familiares']}"]]
#  table table13
  
  start_new_page
  fill_color "000000"

  text "\n Percepção da UE sobre a Dimensão 7", :style => :bold
#    image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d7.png"
  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
#    image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d7i1.png", :position => :left 
#    image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d7i2.png"

 # answers711 = ue.mean_question("7.1.1",service_level)
 # answers712 = ue.mean_question("7.1.2",service_level)
 # answers713 = ue.mean_question("7.1.3",service_level)
 # answers714 = ue.mean_question("7.1.4",service_level)
 # answers715 = ue.mean_question("7.1.5",service_level)
 # answers721 = ue.mean_question("7.2.1",service_level)
 # answers722 = ue.mean_question("7.2.2",service_level)
 # answers723 = ue.mean_question("7.2.3",service_level)
 # answers724 = ue.mean_question("7.2.4",service_level)
 # answers725 = ue.mean_question("7.2.5",service_level)

  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar"
 # table15 = [["Resposta","Professores","Gestores","Educandos","Func. de Apoio","Familiares"],["7.1.1","#{answers711['Professores']}","#{answers711['Gestores']}","#{answers711['Educandos']}","#{answers711['Funcionarios']}","#{answers711['Familiares']}"],["7.1.2","#{answers712['Professores']}","#{answers712['Gestores']}","#{answers712['Educandos']}","#{answers712['Funcionarios']}","#{answers712['Familiares']}"],["7.1.3","#{answers713['Professores']}","#{answers713['Gestores']}","#{answers713['Educandos']}","#{answers713['Funcionarios']}","#{answers713['Familiares']}"],["7.1.4","#{answers714['Professores']}","#{answers714['Gestores']}","#{answers714['Educandos']}","#{answers714['Funcionarios']}","#{answers714['Familiares']}"],["7.1.5","#{answers715['Professores']}","#{answers715['Gestores']}","#{answers715['Educandos']}","#{answers715['Funcionarios']}","#{answers715['Familiares']}"],["7.2.1","#{answers721['Professores']}","#{answers721['Gestores']}","#{answers721['Educandos']}","#{answers721['Funcionarios']}","#{answers721['Familiares']}"],["7.2.2","#{answers722['Professores']}","#{answers722['Gestores']}","#{answers722['Educandos']}","#{answers722['Funcionarios']}","#{answers722['Familiares']}"],["7.2.3","#{answers723['Professores']}","#{answers723['Gestores']}","#{answers723['Educandos']}","#{answers723['Funcionarios']}","#{answers723['Familiares']}"],["7.2.4","#{answers711['Professores']}","#{answers724['Gestores']}","#{answers724['Educandos']}","#{answers724['Funcionarios']}","#{answers724['Familiares']}"],["7.2.5","#{answers725['Professores']}","#{answers725['Gestores']}","#{answers725['Educandos']}","#{answers725['Funcionarios']}","#{answers725['Familiares']}"]]
#  table table15

  start_new_page

  fill_color "000000"

  text "\n Percepção da UE sobre a Dimensão 8", :style => :bold
#    image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d8.png"
  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
#    image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d8i1.png", :position => :left 

 # answers811 = ue.mean_question("8.1.1",service_level)
 # answers812 = ue.mean_question("8.1.2",service_level)
 # answers813 = ue.mean_question("8.1.3",service_level)
 # answers814 = ue.mean_question("8.1.4",service_level)
 # answers815 = ue.mean_question("8.1.5",service_level)

  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar "
 # table17 = [["Resposta","Professores","Gestores","Educandos","Func. de Apoio","Familiares"],["8.1.1","#{answers811['Professores']}","#{answers811['Gestores']}","#{answers811['Educandos']}","#{answers811['Funcionarios']}","#{answers811['Familiares']}"],["8.1.2","#{answers812['Professores']}","#{answers812['Gestores']}","#{answers812['Educandos']}","#{answers812['Funcionarios']}","#{answers812['Familiares']}"],["8.1.3","#{answers813['Professores']}","#{answers813['Gestores']}","#{answers813['Educandos']}","#{answers813['Funcionarios']}","#{answers813['Familiares']}"],["8.1.4","#{answers814['Professores']}","#{answers814['Gestores']}","#{answers814['Educandos']}","#{answers814['Funcionarios']}","#{answers814['Familiares']}"],["8.1.5","#{answers815['Professores']}","#{answers815['Gestores']}","#{answers815['Educandos']}","#{answers815['Funcionarios']}","#{answers815['Familiares']}"]]
#  table table17
  
  start_new_page
  fill_color "000000"

  text "\n Percepção da UE sobre a Dimensão 9", :style => :bold
#    image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d9.png"
  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
#    image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d9i1.png", :position => :left 
#    image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d9i2.png"
#    image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d9i3.png", :position => :left 

 # answers911 = ue.mean_question("9.1.1",service_level)
  #answers912 = ue.mean_question("9.1.2",service_level)
  #answers921 = ue.mean_question("9.2.1",service_level)
  #answers922 = ue.mean_question("9.2.2",service_level)
  #answers923 = ue.mean_question("9.2.3",service_level)
  #answers931 = ue.mean_question("9.3.1",service_level)
  #answers932 = ue.mean_question("9.3.2",service_level)

  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar "
 # table19 = [["Resposta","Professores","Gestores","Educandos","Func. de Apoio","Familiares"],["9.1.1","#{answers911['Professores']}","#{answers911['Gestores']}","#{answers911['Educandos']}","#{answers911['Funcionarios']}","#{answers911['Familiares']}"],["9.1.2","#{answers912['Professores']}","#{answers912['Gestores']}","#{answers912['Educandos']}","#{answers912['Funcionarios']}","#{answers912['Familiares']}"],["9.2.1","#{answers921['Professores']}","#{answers921['Gestores']}","#{answers921['Educandos']}","#{answers921['Funcionarios']}","#{answers921['Familiares']}"],["9.2.2","#{answers922['Professores']}","#{answers922['Gestores']}","#{answers922['Educandos']}","#{answers922['Funcionarios']}","#{answers922['Familiares']}"],["9.2.3","#{answers923['Professores']}","#{answers923['Gestores']}","#{answers923['Educandos']}","#{answers923['Funcionarios']}","#{answers923['Familiares']}"],["9.3.1","#{answers931['Professores']}","#{answers931['Gestores']}","#{answers931['Educandos']}","#{answers931['Funcionarios']}","#{answers931['Familiares']}"],["9.3.2","#{answers932['Professores']}","#{answers932['Gestores']}","#{answers932['Educandos']}","#{answers932['Funcionarios']}","#{answers932['Familiares']}"]]
#  table table19

  start_new_page

  fill_color "000000"

  text "\n Percepção da UE sobre a Dimensão 10", :style => :bold
#  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d10.png"

  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
#  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d10i1.png", :position => :left 
#   image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d10i2.png"
#   image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d10i3.png", :position => :left 
#  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d10i4.png", :position => :left 
#  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d10i5.png", :position => :left 

 # answers1011 = ue.mean_question("10.1.1",service_level)
 # answers1012 = ue.mean_question("10.1.2",service_level)
 # answers1021 = ue.mean_question("10.2.1",service_level)
 # answers1022 = ue.mean_question("10.2.2",service_level)
 # answers1023 = ue.mean_question("10.2.3",service_level)
 # answers1031 = ue.mean_question("10.3.1",service_level)
 # answers1032 = ue.mean_question("10.3.2",service_level)
 # answers1041 = ue.mean_question("10.4.1",service_level)
 # answers1042 = ue.mean_question("10.4.2",service_level)
 # answers1051 = ue.mean_question("10.5.1",service_level)

  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar "
 # table21 = [["Resposta","Professores","Gestores","Educandos","Func. de Apoio","Familiares"],["10.1.1","#{answers1011['Professores']}","#{answers1011['Gestores']}","#{answers1011['Educandos']}","#{answers1011['Funcionarios']}","#{answers1011['Familiares']}"],["10.1.2","#{answers1012['Professores']}","#{answers1012['Gestores']}","#{answers1012['Educandos']}","#{answers1012['Funcionarios']}","#{answers1012['Familiares']}"],["10.2.1","#{answers1021['Professores']}","#{answers1021['Gestores']}","#{answers1021['Educandos']}","#{answers1021['Funcionarios']}","#{answers1021['Familiares']}"],["10.2.2","#{answers1022['Professores']}","#{answers1022['Gestores']}","#{answers1022['Educandos']}","#{answers1022['Funcionarios']}","#{answers1022['Familiares']}"],["10.2.3","#{answers1023['Professores']}","#{answers1023['Gestores']}","#{answers1023['Educandos']}","#{answers1023['Funcionarios']}","#{answers1023['Familiares']}"],["10.3.1","#{answers1031['Professores']}","#{answers1031['Gestores']}","#{answers1031['Educandos']}","#{answers1031['Funcionarios']}","#{answers1031['Familiares']}"],["10.3.2","#{answers1032['Professores']}","#{answers1032['Gestores']}","#{answers1032['Educandos']}","#{answers1032['Funcionarios']}","#{answers1032['Familiares']}"],["10.4.1","#{answers1041['Professores']}","#{answers1041['Gestores']}","#{answers1041['Educandos']}","#{answers1041['Funcionarios']}","#{answers1041['Familiares']}"],["10.4.2","#{answers1042['Professores']}","#{answers1042['Gestores']}","#{answers1042['Educandos']}","#{answers1042['Funcionarios']}","#{answers1042['Familiares']}"],["10.5.1","#{answers1051['Professores']}","#{answers1051['Gestores']}","#{answers1051['Educandos']}","#{answers1051['Funcionarios']}","#{answers1051['Familiares']}"]]
#  table table21

  start_new_page
  fill_color "000000"

  text "\n Percepção da UE sobre a Dimensão 11", :style => :bold
#  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d11.png"

  text "\n Percepção da UE sobre cada indicador de qualidade", :style => :bold
#  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d11i1.png", :position => :left 
#  image "#{RAILS_ROOT}/public/graficos/#{ue.name}_#{service_level.name}_d11i2.png"
   
 # answers1111 = ue.mean_question("11.1.1",service_level)
 # answers1112 = ue.mean_question("11.1.2",service_level)
 # answers1121 = ue.mean_question("11.2.1",service_level)
 # answers1122 = ue.mean_question("11.2.2",service_level)
 # answers1123 = ue.mean_question("11.2.3",service_level)
  
  text "INSERIR AQUI OS GRÁFICOS DOS INDICADORES DA DIMENSÃO 11 (6 POR PÁGINA) "

  text "\n Médias das respostas atribuídas a cada questão da dimensão, por segmento escolar "
#  table23 = [["Resposta","Professores","Gestores","Educandos","Func. de Apoio","Familiares"],["11.1.1","#{answers1111['Professores']}","#{answers1111['Gestores']}","#{answers1111['Educandos']}","#{answers1111['Funcionarios']}","#{answers1111['Familiares']}"],["11.1.2","#{answers1112['Professores']}","#{answers1112['Gestores']}","#{answers1112['Educandos']}","#{answers1112['Funcionarios']}","#{answers1112['Familiares']}"],["11.2.1","#{answers1121['Professores']}","#{answers1121['Gestores']}","#{answers1121['Educandos']}","#{answers1121['Funcionarios']}","#{answers1121['Familiares']}"],["11.2.2","#{answers1122['Professores']}","#{answers1122['Gestores']}","#{answers1122['Educandos']}","#{answers1122['Funcionarios']}","#{answers1122['Familiares']}"],["11.2.3","#{answers1123['Professores']}","#{answers1123['Gestores']}","#{answers1123['Educandos']}","#{answers1123['Funcionarios']}","#{answers1123['Familiares']}"]]
#  table table23

end
end 
end