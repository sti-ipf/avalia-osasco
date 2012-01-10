# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
CRECHE = 0
EMEI = 1
EMEF = 2
EJA = 3
BURJATO = 4
CRECHE_CONVENIADA = 5

# Sorocaba
#EMEI_EMEF = 6
#ENSINO_MEDIO = 7


admin = AdminUser.create(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')

levels = ServiceLevel.create([{:name => "CRECHE"}, {:name => "EMEI"}, {:name => "EMEF"}, {:name => "EJA"}, {:name => "BURJATO"}, {:name => "CRECHE CONVENIADA"}])
# Sorocaba
#, {:name => "EMEI E EMEF"}, {:name => "ENSINO MEDIO"}


# # Criação das Creches
schools_creche = School.create([{:name => "CRECHE ALHA ELIAS ABIBE", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE ALZIRA SILVA MEDEIROS", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE AMELIA TOZZETO VIVIANE", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE BENEDITA DE OLIVEIRA", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE DAISY RIBEIRO NEVES", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE ELZA BATISTON", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE EZIO MELLI", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE GIUSEPPA BERSANI MICHELIN", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE HERMINIA LOPES", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE HILDA ALVES DOS SANTOS MARIM", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE IDA BELMONTE BISCUOLA", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE INES SANCHES MENDES", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE JOAO CORREA", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE JOAQUINA FRANCA GARCIA, PROFa", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE JOSE ESPINOSA", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE JOSE CARLOS DI MAMBRO, PE.", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE LIDIA THOMAZ", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE MARIA BENEDITA CONSTANCIO, IRMA", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE MARIA JOSE DA ANUNCIACAO", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE MERCEDES CORREA RUIZ BATISTA", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE OLGA CAMOLESI PAVAO", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE OLIMPIA MARIA DE JESUS CARVALHO", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE PEDRO PENOV", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE RECANTO ALEGRE ", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE ROSA BROSEGHINI", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE ROSA PEREIRA CRE", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE SADAMITU OMOSAKO", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE SERAPHINA BISSOLATTI", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE SERGIO ZANARDI", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE SILVIA FERREIRA FARAH, PROFa", :service_levels => [levels[CRECHE]]},
                              {:name => "CRECHE VILMA CATAN", :service_levels => [levels[CRECHE]]}
                            ])
# # Criação das EMEIs
schools_creche = School.create([{:name => "EMEI ADELAIDE DIAS", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI ADHEMAR PEREIRA DE BARROS, DR.", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI ALICE MANHOLER PITERI", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI ALIPIO PEREIRA DOS SANTOS, PROF.", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI ANTONIO PAULINO RIBEIRO", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI CRISTINE APARECIDA DE OLIVEIRA BRAGA", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI DALVA MIRIAN PORTELLA MACHADO, PROFª.", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI DÉSCIO MENDES PEREIRA, DR.", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI ELIDE ALVES DÓRIA, PROFª", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI EMIR MACEDO NOGUEIRA. PROF.", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI ESMERALDA FERREIRA SIMÃO NOBREGA, PROFª.", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI ESTEVÃO BRETT", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI FERNANDO BUONADUCE, PROF.", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI FORTUNATA PEREIRA DE JESUS SANTOS", :service_levels => [levels[EMEI]]},
                              {:name => "CEMEI GERTRUDES DE ROSSI", :service_levels => [levels[EMEI], levels[CRECHE]]},
                              {:name => "EMEI HELENA COUTINHO", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI IGNÊS COLLINO", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI JAPHET FONTES ", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI JOSÉ FLÁVIO DE FREITAS, PROF.", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI LUZIA MOMI SASSO", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI MARIA ALVES DÓRIA, PROFª", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI MARIA APARECIDA DE CAMARGO DAMY RODRIGUES, PROFª", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI MARIA BERTONI FIORITA, PROFª", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI MARIA MADALENA L. B. FREIXEDA", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI NAIR BELLACOSA WARZEKA, PROFª", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI OMAR OGEDA MARTINS", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI OSVALDO GONÇALVES DE CARVALHO", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI OSWALDO SALLES NEMER", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI PEDRO MARTINO", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI PROVIDÊNCIA DOS ANJOS CARREIRA", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI SALVADOR SACCO", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI SEVERINO DE ARAUJO FREIRE", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI SÔNIA MARIA DE ALMEIDA FERNANDES, PROFª", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI THEREZA BIANCHI COLLINO", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI VIVALDO MARTINS SIMÕES, DR.", :service_levels => [levels[EMEI]]},
                              {:name => "EMEI YOLANDA BOTARO VICENTE", :service_levels => [levels[EMEI]]}])

# # Criação das EMEF
schools_emef = School.create([{:name => "EMEF ALFREDO FARHAT, DEPUTADO", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF ALICE RABECHINI FERREIRA", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF ALIPIO DA SILVA LAVOURA, PROF.", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF ANEZIO CABRAL, PROF.", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF ANTONIO DE SAMPAIO, GENERAL", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF BENEDICTO WESCHENFELDER", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF BENEDITO ALVES TURIBIO", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF BITTENCOURT, MARECHAL", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF CECILIA CORREA CASTELANI, PROFa", :service_levels => [levels[EMEF]]},
                              {:name => "EMEF DOMINGOS BLASCO, MAESTRO", :service_levels => [levels[EMEF]]},
                              {:name => "EMEF ELIDIO MANTOVANI, MONSENHOR", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF ELZA DE CARVALHO MELLO BATTISTON, PROFa", :service_levels => [levels[EMEF]]},
                              {:name => "EMEF FRANCISCO CAVALCANTI PONTES DE MIRANDA", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF FRANCISCO MANUEL LUMBRALES DE SA CARNEIRO, DR.", :service_levels => [levels[EMEF]]},
                              {:name => "EMEF GASPAR DA MADRE DE DEUS, FREI", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF HUGO RIBEIRO DE ALMEIDA, DR.", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF JOAO CAMPESTRINI, PROF.", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEIEF JOAO EUCLYDES PEREIRA, PROF.", :service_levels => [levels[EMEF], levels[EMEI]]},
                              {:name => "EMEF JOAO GUIMARAES ROSA", :service_levels => [levels[EMEF]]},
                              {:name => "EMEF JOAO LARIZZATTI, PROF.", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF JOSE GROSSI DIAS, PADRE", :service_levels => [levels[EMEF]]},
                              {:name => "EMEF JOSE MANOEL AYRES, DR.", :service_levels => [levels[EMEF]]},
                              {:name => "EMEF JOSE MARTINIANO DE ALENCAR", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF JOSE VERISSIMO DE MATOS", :service_levels => [levels[EMEF]]},
                              {:name => "EMEF JOSIAS BAPTISTA, PASTOR", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF LAERTE JOSE DOS SANTOS, PROF.", :service_levels => [levels[EMEF]]},
                              {:name => "EMEF LUCIANO FELICIO BIONDO, PROF.", :service_levels => [levels[EMEF]]},
                              {:name => "EMEF LUIZ BORTOLOSSO", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF MANOEL BARBOSA DE SOUZA, PROF.", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF MANOEL TERTULIANO DE CERQUEIRA, PROF.", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF MARINA SADDI HAIDAR", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF MARINA VON PUTTKAMMER MELLI", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF MAX ZENDRON, PROF.", :service_levels => [levels[EMEF]]},
                              {:name => "EMEF OLAVO ANTONIO BARBOSA SPINOLA , PROF", :service_levels => [levels[EMEF]]},
                              {:name => "EMEF OLINDA MOREIRA LEMES DA CUNHA, PROFa", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF ONEIDE BORTOLOTE", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF OSCAR PENNACINO,", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF OSVALDO QUIRINO SIMOES", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF QUINTINO BOCAIUVA", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF RENATO FIUZA TELES, PROF.", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF SAAD BECHARA", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF TECLA MERLO, IRMA", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF TEREZINHA MARTINS PEREIRA, PROFa", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF TOBIAS BARRETO DE MENEZES", :service_levels => [levels[EMEF], levels[EJA]]},
                              {:name => "EMEF VICTOR BRECHERET , ESCULTOR", :service_levels => [levels[EMEF], levels[EJA]]}])

# # Criação das CEMEIs
schools_cemei = School.create([{:name => "CEMEI ALBERTO SANTOS DUMONT", :service_levels => [levels[CRECHE], levels[EMEI]]},
                              {:name => "CEMEI FORTUNATO ANTIÓRIO", :service_levels => [levels[CRECHE], levels[EMEI]]},
                              {:name => "CEMEI JOÃO DE FARIAS", :service_levels => [levels[CRECHE], levels[EMEI]]},
                              {:name => "CEMEI JOSÉ ERMÍRIO DE MORAES, SENADOR", :service_levels => [levels[CRECHE], levels[EMEI]]},
                              {:name => "CRECHE LEONIL CRÊ BORTOLOSSO", :service_levels => [levels[CRECHE]]},
                              {:name => "CEMEI LOURDES CÂNDIDA DE FARIA", :service_levels => [levels[CRECHE], levels[EMEI]]},
                              {:name => "CEMEI MÁRIO QUINTANA", :service_levels => [levels[CRECHE], levels[EMEI]]},
                              {:name => "CEMEI RUBENS BANDEIRA", :service_levels => [levels[CRECHE], levels[EMEI]]},
                              {:name => "CEMEI VILMA FOLTRAN PORTELLA", :service_levels => [levels[CRECHE], levels[EMEI], levels[EJA]]},
                              {:name => "CEMEI ZAÍRA COLLINO ODÁLIA", :service_levels => [levels[CRECHE], levels[EMEI]]}])

# # Criação das EMEIEFs
schools_emeief = School.create([{:name => "EMEIEF COLINAS D'OESTE", :service_levels => [levels[EMEI], levels[EMEF], levels[EJA]]},
                              {:name => "EMEIEF ÉLIO APARECIDO DA SILVA", :service_levels => [levels[EMEI], levels[EMEF], levels[EJA]]},
                              {:name => "EMEIEF ETIENE SALES CAMPELO, PROFª", :service_levels => [levels[EMEI], levels[EMEF], levels[EJA]]},
                              {:name => "EMEIEF MESSIAS GONÇALVES DA SILVA", :service_levels => [levels[EMEI], levels[EMEF], levels[EJA]]},
                              {:name => "EMEIEF VALTER DE OLIVEIRA FERREIRA, PROF.", :service_levels => [levels[EMEI], levels[EMEF], levels[EJA]]},
                              {:name => "EMEIEF ZULEIKA GONÇALVES MENDES, PROFª", :service_levels => [levels[EMEI], levels[EMEF], levels[EJA]]}])

# # Criação das CEMEIEFs
schools_cemeief = School.create([{:name => "CEU ZONA NORTE (ZILDA ARNS, Drª)", :service_levels => [levels[CRECHE], levels[EMEI], levels[EMEF], levels[EJA]]},
                              {:name => "CEMEIEF MARIA JOSÉ FERREIRA FERRAZ, PROFª.", :service_levels => [levels[CRECHE], levels[EMEI], levels[EMEF]]},
                              {:name => "CEMEIEF MARIA TARCILLA FORNASARO MELLI", :service_levels => [levels[CRECHE], levels[EMEI], levels[EMEF]]},
                              {:name => "CEMEIEF ZILDA ARNS, Drª", :service_levels => [levels[CRECHE], levels[EMEI], levels[EMEF]]},
                              {:name => "CEMEI MÁRIO SEBASTIÃO ALVES DE LIMA", :service_levels => [levels[CRECHE], levels[EMEI]]}])

# # Criação das BURJATO
schools_burjato = School.create([{:name => "DR. EDMUNDO CAMPANHA BURJATO", :service_levels => [levels[BURJATO]]}])

# # Criação das CRECHES Conveniadas
schools_creches_conveniadas = School.create([{:name => "Centro de Participação Popular do Jardim Veloso".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação União de Mães do Jardim das Flores".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação Faça uma Criança Sorrir de Osasco e Região – Núcleo I".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação Faça uma Criança Sorrir de Osasco e Região – Núcleo II Alfacriso".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação das Mães do Jardim Veloso".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação das Mães Unidas do Novo Osasco – AMUNO I".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação das Mães Unidas do Novo Osasco – AMUNO II".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação Beneficente Gotas de Amor".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação Quintal Mágico".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Centro Social Santo Antonio".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação Padre Domingos Barbé".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação das Mulheres pela Educação – Núcleo Aventura do Aprender".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação das Mulheres pela Educação – Núcleo Brilho do Aprender".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação das Mulheres pela Educação – Núcleo Casa do Aprender".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação das Mulheres pela Educação – Núcleo Cecília Meireles".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação das Mulheres pela Educação – Núcleo Começando Aprender".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação das Mulheres pela Educação – Núcleo Menino Jesus".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação das Mulheres pela Educação – Núcleo Recanto do Aprender".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação das Mulheres em Defesa à Criança Helena Maria".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação das Mulheres em Defesa à Criança – Tarcila do Amaral".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação de Proteção à Maternidade e à Adolescência (ASPROMATINA) – Padre Domingos Tonini".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação de Proteção à Maternidade e à Adolescência (ASPROMATINA) – Padre Guerrino".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "ASCC – Associação Solidária Crescendo Cidadã I - Açucará".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "ASCC – Associação Solidária Crescendo Cidadã II – Bela Vista".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação de Educação Popular Pixote I".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Associação de Educação Popular Pixote II".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]},
                                                {:name => "Lar da Criança Emmanuel Núcleo Kardecista 21 de Abril".upcase, :service_levels => [levels[CRECHE_CONVENIADA]]}])


schools_faltando = School.create([{:name => "CEMEIEF DARCY RIBEIRO, PROF.", :service_levels => [levels[CRECHE], levels[EMEI], levels[EMEF]]}])

segments_creche = Segment.create([{:name => "Familiares", :service_level => levels[CRECHE]},
                                {:name => "Funcionários", :service_level => levels[CRECHE]},
                                {:name => "Professores", :service_level => levels[CRECHE]},
                                {:name => "Gestores", :service_level => levels[CRECHE]}])

segments_emei = Segment.create([{:name => "Familiares", :service_level => levels[EMEI]},
                                {:name => "Funcionários", :service_level => levels[EMEI]},
                                {:name => "Professores", :service_level => levels[EMEI]},
                                {:name => "Gestores", :service_level => levels[EMEI]}])

segments_emef = Segment.create([{:name => 'Educandos', :service_level => levels[EMEF]},
                                {:name => 'Familiares', :service_level => levels[EMEF]},
                                {:name => 'Funcionários', :service_level => levels[EMEF]},
                                {:name => 'Professores', :service_level => levels[EMEF]},
                                {:name => 'Gestores', :service_level => levels[EMEF]}])

segments_eja = Segment.create([{:name => 'Educandos', :service_level => levels[EJA]},
                                {:name => 'Funcionários', :service_level => levels[EJA]},
                                {:name => 'Gestores', :service_level => levels[EJA]},
                                {:name => 'Professores', :service_level => levels[EJA]}])

segments_burjato = Segment.create([{:name => 'Trabalhadores', :service_level => levels[BURJATO]},
                                {:name => 'Gestores', :service_level => levels[BURJATO]},
                                {:name => 'Familiares', :service_level => levels[BURJATO]}])

segments_creches_conveniadas = Segment.create([{:name => 'Gestores', :service_level => levels[CRECHE_CONVENIADA]},
                                {:name => 'Coordenadores pedagógicos', :service_level => levels[CRECHE_CONVENIADA]},
                                {:name => 'Professores', :service_level => levels[CRECHE_CONVENIADA]},
                                {:name => 'Funcionários', :service_level => levels[CRECHE_CONVENIADA]},
                                {:name => 'Familiares', :service_level => levels[CRECHE_CONVENIADA]}])


# Sorocaba
# segments_ensino_medio = Segment.create([{:name => 'Educandos', :service_level => levels[ENSINO_MEDIO]},
#                                 {:name => 'Familiares', :service_level => levels[ENSINO_MEDIO]},
#                                 {:name => 'Funcionários', :service_level => levels[ENSINO_MEDIO]},
#                                 {:name => 'Professores', :service_level => levels[ENSINO_MEDIO]},
#                                 {:name => 'Gestores', :service_level => levels[ENSINO_MEDIO]}])

# segments_emei_emef = Segment.create([{:name => 'Professores', :service_level => levels[EMEI_EMEF]}])




dimensions_creche = Dimension.create([{:name => 'Ambiente educativo', :number => 1, :service_level => levels[CRECHE]},
                                    {:name => 'Ambiente físico escolar e materiais', :number => 2, :service_level => levels[CRECHE]},
                                    {:name => 'Planejamento institucional e prática pedagógica', :number => 3, :service_level => levels[CRECHE]},
                                    {:name => 'Avaliação', :number => 4, :service_level => levels[CRECHE]},
                                    {:name => 'Acesso e permanência dos educandos na escola', :number => 5, :service_level => levels[CRECHE]},
                                    {:name => 'Promoção da saúde', :number => 6, :service_level => levels[CRECHE]},
                                    {:name => 'Educação socioambiental e práticas ecopedagógicas', :number => 7, :service_level => levels[CRECHE]},
                                    {:name => 'Envolvimento com as famílias e participação na rede de proteção social', :number => 8, :service_level => levels[CRECHE]},
                                    {:name => 'Gestão escolar democrática', :number => 9, :service_level => levels[CRECHE]},
                                    {:name => 'Formação e condições de trabalho dos profissionais da escola', :number => 10, :service_level => levels[CRECHE]}])


dimensions_emei = Dimension.create([{:name => 'Ambiente educativo', :number => 1, :service_level => levels[EMEI]},
                                    {:name => 'Ambiente físico escolar e materiais', :number => 2, :service_level => levels[EMEI]},
                                    {:name => 'Planejamento institucional e prática pedagógica', :number => 3, :service_level => levels[EMEI]},
                                    {:name => 'Avaliação', :number => 4, :service_level => levels[EMEI]},
                                    {:name => 'Acesso e permanência dos educandos na escola', :number => 5, :service_level => levels[EMEI]},
                                    {:name => 'Promoção da saúde', :number => 6, :service_level => levels[EMEI]},
                                    {:name => 'Educação socioambiental e práticas ecopedagógicas', :number => 7, :service_level => levels[EMEI]},
                                    {:name => 'Envolvimento com as famílias e participação na rede de proteção social', :number => 8, :service_level => levels[EMEI]},
                                    {:name => 'Gestão escolar democrática', :number => 9, :service_level => levels[EMEI]},
                                    {:name => 'Formação e condições de trabalho dos profissionais da escola', :number => 10, :service_level => levels[EMEI]}])

dimensions_emef = Dimension.create([{:name => 'Ambiente educativo', :number => 1, :service_level => levels[EMEF]},
                                    {:name => 'Ambiente físico escolar e materiais', :number => 2, :service_level => levels[EMEF]},
                                    {:name => 'Planejamento institucional e prática pedagógica', :number => 3, :service_level => levels[EMEF]},
                                    {:name => 'Avaliação', :number => 4, :service_level => levels[EMEF]},
                                    {:name => 'Acesso e permanência dos educandos na escola', :number => 5, :service_level => levels[EMEF]},
                                    {:name => 'Promoção da saúde', :number => 6, :service_level => levels[EMEF]},
                                    {:name => 'Educação socioambiental e práticas ecopedagógicas', :number => 7, :service_level => levels[EMEF]},
                                    {:name => 'Envolvimento com as famílias e participação na rede de proteção social', :number => 8, :service_level => levels[EMEF]},
                                    {:name => 'Gestão escolar democrática', :number => 9, :service_level => levels[EMEF]},
                                    {:name => 'Formação e condições de trabalho dos profissionais da escola', :number => 10, :service_level => levels[EMEF]},
                                    {:name => 'Processos de alfabetização e letramento', :number => 11, :service_level => levels[EMEF]}])

dimensions_eja = Dimension.create([{:name => 'Ambiente educativo', :number => 1, :service_level => levels[EJA]},
                                    {:name => 'Planejamento Institucional e Prática Pedagógica', :number => 2, :service_level => levels[EJA]},
                                    {:name => 'Avaliação', :number => 3, :service_level => levels[EJA]},
                                    {:name => 'Acesso e permanência dos educandos na escola', :number => 4, :service_level => levels[EJA]},
                                    {:name => 'Promoção da saúde', :number => 5, :service_level => levels[EJA]},
                                    {:name => 'Educação socioambiental e práticas ecopedagógicas', :number => 6, :service_level => levels[EJA]},
                                    {:name => 'Gestão Escolar Democrática', :number => 7, :service_level => levels[EJA]},
                                    {:name => 'Formação e condições de trabalho dos profissionais da escola', :number => 8, :service_level => levels[EJA]},
                                    {:name => 'Processos de alfabetização e letramento', :number => 9, :service_level => levels[EJA]}])

dimensions_conveniada = Dimension.create([{:name => 'Ambiente educativo', :number => 1, :service_level => levels[CRECHE_CONVENIADA]},
                                    {:name => 'Ambiente físico escolar e materiais', :number => 2, :service_level => levels[CRECHE_CONVENIADA]},
                                    {:name => 'Planejamento institucional e prática pedagógica', :number => 3, :service_level => levels[CRECHE_CONVENIADA]},
                                    {:name => 'Avaliação', :number => 4, :service_level => levels[CRECHE_CONVENIADA]},
                                    {:name => 'Acesso e permanência dos educandos na escola', :number => 5, :service_level => levels[CRECHE_CONVENIADA]},
                                    {:name => 'Promoção da saúde', :number => 6, :service_level => levels[CRECHE_CONVENIADA]},
                                    {:name => 'Educação socioambiental e práticas ecopedagógicas', :number => 7, :service_level => levels[CRECHE_CONVENIADA]},
                                    {:name => 'Envolvimento com as famílias e participação na rede de proteção social', :number => 8, :service_level => levels[CRECHE_CONVENIADA]},
                                    {:name => 'Gestão escolar democrática', :number => 9, :service_level => levels[CRECHE_CONVENIADA]},
                                    {:name => 'Formação e condições de trabalho dos profissionais da escola', :number => 10, :service_level => levels[CRECHE_CONVENIADA]}]
                                    )

dimensions_burjato = Dimension.create([{:name => 'Ambiente educativo', :number => 1, :service_level => levels[BURJATO]},
                                    {:name => 'Ambiente físico escolar e materiais', :number => 2, :service_level => levels[BURJATO]},
                                    {:name => 'Planejamento institucional e prática pedagógica', :number => 3, :service_level => levels[BURJATO]},
                                    {:name => 'Avaliação', :number => 4, :service_level => levels[BURJATO]},
                                    {:name => 'Acesso e permanência dos educandos na escola', :number => 5, :service_level => levels[BURJATO]},
                                    {:name => 'Promoção da saúde', :number => 6, :service_level => levels[BURJATO]},
                                    {:name => 'Educação socioambiental e práticas ecopedagógicas', :number => 7, :service_level => levels[BURJATO]},
                                    {:name => 'Envolvimento com as famílias e participação na rede de proteção social', :number => 8, :service_level => levels[BURJATO]},
                                    {:name => 'Gestão escolar democrática', :number => 9, :service_level => levels[BURJATO]},
                                    {:name => 'Formação e condições de trabalho dos profissionais da escola', :number => 10, :service_level => levels[BURJATO]},
                                    {:name => 'Processos de alfabetização e letramento', :number => 11, :service_level => levels[BURJATO]}])

# Sorocaba
# dimensions_em = Dimension.create([{:name => 'Ambiente educativo', :number => 1, :service_level => levels[ENSINO_MEDIO]},
#                                     {:name => 'Ambiente físico escolar e materiais', :number => 2, :service_level => levels[ENSINO_MEDIO]},
#                                     {:name => 'Planejamento institucional e prática pedagógica', :number => 3, :service_level => levels[ENSINO_MEDIO]},
#                                     {:name => 'Avaliação', :number => 4, :service_level => levels[ENSINO_MEDIO]},
#                                     {:name => 'Acesso e permanência dos educandos na escola', :number => 5, :service_level => levels[ENSINO_MEDIO]},
#                                     {:name => 'Promoção da saúde', :number => 6, :service_level => levels[ENSINO_MEDIO]},
#                                     {:name => 'Educação socioambiental e práticas ecopedagógicas', :number => 7, :service_level => levels[ENSINO_MEDIO]},
#                                     {:name => 'Envolvimento com as famílias e participação na rede de proteção social', :number => 8, :service_level => levels[ENSINO_MEDIO]},
#                                     {:name => 'Gestão escolar democrática', :number => 9, :service_level => levels[ENSINO_MEDIO]},
#                                     {:name => 'Formação e condições de trabalho dos profissionais da escola', :number => 10, :service_level => levels[ENSINO_MEDIO]},
#                                     {:name => 'Processos de alfabetização e letramento', :number => 11, :service_level => levels[CRECHE_CONVENIADA]}])


# dimensions_emeif = Dimension.create([{:name => 'Ambiente educativo', :number => 1, :service_level => levels[EMEI_EMEF]},
#                                     {:name => 'Ambiente físico escolar e materiais', :number => 2, :service_level => levels[EMEI_EMEF]},
#                                     {:name => 'Planejamento institucional e prática pedagógica', :number => 3, :service_level => levels[EMEI_EMEF]},
#                                     {:name => 'Avaliação', :number => 4, :service_level => levels[EMEI_EMEF]},
#                                     {:name => 'Acesso e permanência dos educandos na escola', :number => 5, :service_level => levels[EMEI_EMEF]},
#                                     {:name => 'Promoção da saúde', :number => 6, :service_level => levels[EMEI_EMEF]},
#                                     {:name => 'Educação socioambiental e práticas ecopedagógicas', :number => 7, :service_level => levels[EMEI_EMEF]},
#                                     {:name => 'Envolvimento com as famílias e participação na rede de proteção social', :number => 8, :service_level => levels[EMEI_EMEF]},
#                                     {:name => 'Gestão escolar democrática', :number => 9, :service_level => levels[EMEI_EMEF]},
#                                     {:name => 'Formação e condições de trabalho dos profissionais da escola', :number => 10, :service_level => levels[EMEI_EMEF]},
#                                     {:name => 'Processos de alfabetização e letramento', :number => 11, :service_level => levels[EMEI_EMEF]}])

indicators_burjato = Indicator.create([{:name => 'Amizade e solidariedade', :number => 1, :dimension => dimensions_burjato[0]},
                                    {:name => 'Alegria', :number => 2, :dimension => dimensions_burjato[0]},
                                    {:name => 'Combate à discriminação', :number => 3, :dimension => dimensions_burjato[0]},
                                    {:name => 'Mediação de conflitos', :number => 4, :dimension => dimensions_burjato[0]},
                                    {:name => 'Respeito ao outro', :number => 5, :dimension => dimensions_burjato[0]},
                                    {:name => 'Respeito aos direitos dos jovens e  adultos com deficiência', :number => 6, :dimension => dimensions_burjato[0]},
                                    {:name => 'Respeito à dignidade dos jovens e  adultos com deficiência', :number => 7, :dimension => dimensions_burjato[0]},
                                    {:name => 'Respeito à identidade, desejos e interesses dos jovens e adultos', :number => 8, :dimension => dimensions_burjato[0]},
                                    {:name => 'Respeito às ideias, conquistas e produções dos jovens e adultos', :number => 9, :dimension => dimensions_burjato[0]},
                                    {:name => 'Interação entre jovens e adultos', :number => 10, :dimension => dimensions_burjato[0]},

                                    {:name => 'Ambiente físico escolar', :number => 1, :dimension => dimensions_burjato[1]},
                                    {:name => 'Espaços e mobiliários que favoreçam as experiências dos jovens e adultos', :number => 2, :dimension => dimensions_burjato[1]},
                                    {:name => 'Materiais variados e acessíveis aos jovens e adultos', :number => 3, :dimension => dimensions_burjato[1]},
                                    {:name => 'Espaços, materiais e mobiliários para responder aos interesses e necessidades da equipe profissional', :number => 4, :dimension => dimensions_burjato[1]},

                                    {:name => 'Projeto Eco-Político-Pedagógico (PEPP) definido e conhecido por todos', :number => 1, :dimension => dimensions_burjato[2]},
                                    {:name => 'Registro da prática educativa', :number => 2, :dimension => dimensions_burjato[2]},
                                    {:name => 'Planejamento', :number => 3, :dimension => dimensions_burjato[2]},
                                    {:name => 'Contextualização', :number => 4, :dimension => dimensions_burjato[2]},
                                    {:name => 'Incentivo à autonomia e ao trabalho coletivo', :number => 5, :dimension => dimensions_burjato[2]},
                                    {:name => 'Variedades das estratégias e dos recursos de ensino-aprendizagem', :number => 6, :dimension => dimensions_burjato[2]},
                                    {:name => 'Prática pedagógica de apoio à diversidade', :number => 7, :dimension => dimensions_burjato[2]},
                                    {:name => 'Multiplicidade de diferentes linguagens plásticas, simbólicas, musicais e corporais', :number => 8, :dimension => dimensions_burjato[2]},
                                    {:name => 'Preparação para o mundo do trabalho', :number => 9, :dimension => dimensions_burjato[2]},
                                    {:name => 'Atuação do corpo técnico pedagógico – CTP - Corpo Técnico Pedagógico', :number => 10, :dimension => dimensions_burjato[2]},

                                    {:name => 'Monitoramento do processo de aprendizagem dos educandos', :number => 1, :dimension => dimensions_burjato[3]},
                                    {:name => 'Mecanismos de avaliação dos educandos', :number => 2, :dimension => dimensions_burjato[3]},
                                    {:name => 'Participação dos educandos na avaliação de sua aprendizagem', :number => 3, :dimension => dimensions_burjato[3]},
                                    {:name => 'Avaliação do trabalho dos profissionais da escola', :number => 4, :dimension => dimensions_burjato[3]},
                                    {:name => 'Compartilhamento, reflexão e uso das avaliações educacionais da Rede Municipal de Ensino de Osasco', :number => 5, :dimension => dimensions_burjato[3]},

                                    {:name => 'Atenção especial aos educandos que faltam', :number => 1, :dimension => dimensions_burjato[4]},
                                    {:name => 'Preocupação com o abandono e evasão', :number => 2, :dimension => dimensions_burjato[4]},

                                    {:name => 'Responsabilidade pela alimentação dos jovens e adultos', :number => 1, :dimension => dimensions_burjato[5]},
                                    {:name => 'Limpeza, salubridade e conforto', :number => 2, :dimension => dimensions_burjato[5]},
                                    {:name => 'Segurança', :number => 3, :dimension => dimensions_burjato[5]},
                                    {:name => 'Cuidados com a higiene e a saúde', :number => 4, :dimension => dimensions_burjato[5]},

                                    {:name => 'Respeito a diversas formas de vida', :number => 1, :dimension => dimensions_burjato[6]},
                                    {:name => 'Práticas ecopedagógicas', :number => 2, :dimension => dimensions_burjato[6]},

                                    {:name => 'Respeito e acolhimento e envolvimento com as famílias', :number => 1, :dimension => dimensions_burjato[7]},
                                    {:name => 'Garantia do direito das famílias de acompanhar as vivências e produções dos jovens e adultos', :number => 2, :dimension => dimensions_burjato[7]},
                                    {:name => 'Participação da Instituição na Rede de Proteção dos Direitos dos Jovens e Adultos com Deficiência', :number => 3, :dimension => dimensions_burjato[7]},

                                    {:name => 'Democratização da gestão e informação', :number => 1, :dimension => dimensions_burjato[8]},
                                    {:name => 'Conselhos atuantes', :number => 2, :dimension => dimensions_burjato[8]},
                                    {:name => 'Parcerias locais e relacionamento da escola com os serviços públicos', :number => 3, :dimension => dimensions_burjato[8]},
                                    {:name => 'Participação efetiva de educandos, pais, responsáveis e comunidade em geral', :number => 4, :dimension => dimensions_burjato[8]},

                                    {:name => 'Formação inicial e continuada', :number => 1, :dimension => dimensions_burjato[9]},
                                    {:name => 'Suficiência da equipe escolar e condições de trabalho', :number => 2, :dimension => dimensions_burjato[9]},
                                    {:name => 'Assiduidade da equipe escolar', :number => 3, :dimension => dimensions_burjato[9]},

                                    {:name => 'Experiências e aproximações com a linguagem oral e escrita', :number => 1, :dimension => dimensions_burjato[10]},
                                    {:name => 'Existência de práticas alfabetizadoras na escola', :number => 2, :dimension => dimensions_burjato[10]},
                                    {:name => 'Acesso e bom Aproveitamento da biblioteca ou sala de leitura', :number => 3, :dimension => dimensions_burjato[10]}])


indicators_eja = Indicator.create([{:name => 'Amizade e solidariedade', :number => 1, :dimension => dimensions_eja[0]},
                                    {:name => 'Alegria', :number => 2, :dimension => dimensions_eja[0]},
                                    {:name => 'Combate à discriminação', :number => 3, :dimension => dimensions_eja[0]},
                                    {:name => 'Mediação de conflitos', :number => 4, :dimension => dimensions_eja[0]},
                                    {:name => 'Respeito ao outro', :number => 5, :dimension => dimensions_eja[0]},
                                    {:name => 'Respeito aos direitos dos jovens, adultos e idosos', :number => 6, :dimension => dimensions_eja[0]},
                                    {:name => 'Ambiente Fisico Escolar', :number => 7, :dimension => dimensions_eja[0]},

                                    {:name => 'Projeto Eco-Político-Pedagógico (PEPP) definido e conhecido por todos', :number => 1, :dimension => dimensions_eja[1]},
                                    {:name => 'Planejamento', :number => 2, :dimension => dimensions_eja[1]},
                                    {:name => 'Contextualização', :number => 3, :dimension => dimensions_eja[1]},
                                    {:name => 'Variedades das estratégias e dos recursos de ensino-aprendizagem', :number => 4, :dimension => dimensions_eja[1]},
                                    {:name => 'Orientação para o mundo do trabalho', :number => 5, :dimension => dimensions_eja[1]},
                                    {:name => 'Incentivo à autonomia e ao trabalho coletivo', :number => 6, :dimension => dimensions_eja[1]},
                                    {:name => 'Prática pedagógica de apoio à diversidade', :number => 7, :dimension => dimensions_eja[1]},
                                    {:name => 'Atuação do Corpo Técnico Pedagógico- CTP', :number => 8, :dimension => dimensions_eja[1]},



                                    {:name => 'Mecanismos de avaliação e monitoramento do processo de aprendizagem dos educandos', :number => 1, :dimension => dimensions_eja[2]},
                                    {:name => 'Participação dos educandos na avaliação de sua aprendizagem', :number => 2, :dimension => dimensions_eja[2]},
                                    {:name => 'Avaliação do trabalho dos profissionais da escola ', :number => 3, :dimension => dimensions_eja[2]},
                                    {:name => 'Compartilhamento, reflexão e uso das avaliações educacionais da Rede Municipal de Ensino de Osasco', :number => 4, :dimension => dimensions_eja[2]},
                                    

                                    {:name => 'Atenção especial aos educandos que faltam, evadem ou abandonam', :number => 1, :dimension => dimensions_eja[3]},
                                    {:name => 'Atenção aos educandos com alguma defasagem de aprendizagem', :number => 2, :dimension => dimensions_eja[3]},
                                    {:name => 'Atenção às necessidades educativas da comunidade', :number => 3, :dimension => dimensions_eja[3]},


                                    {:name => 'Responsabilidade pela alimentação dos jovens, adultos e idosos', :number => 1, :dimension => dimensions_eja[4]},
                                    {:name => 'Limpeza, salubridade e conforto', :number => 2, :dimension => dimensions_eja[4]},
                                    {:name => 'Segurança', :number => 3, :dimension => dimensions_eja[4]},
                                    {:name => 'Cuidados com a higiene e a saúde', :number => 4, :dimension => dimensions_eja[4]},

                                    {:name => 'Respeito a diversas formas de vida', :number => 1, :dimension => dimensions_eja[5]},
                                    {:name => 'Práticas ecopedagógicas', :number => 2, :dimension => dimensions_eja[5]},


                                    {:name => 'Democratização da gestão e informação', :number => 1, :dimension => dimensions_eja[6]},
                                    {:name => 'Conselhos atuantes', :number => 2, :dimension => dimensions_eja[6]},
                                    {:name => 'Participação efetiva de estudantes, pais, responsáveis e comunidade em geral', :number => 3, :dimension => dimensions_eja[6]},
                                    {:name => 'Parcerias locais e relacionamento da escola com os serviços públicos', :number => 4, :dimension => dimensions_eja[6]},



                                    {:name => 'Suficiência da equipe escolar e condições de trabalho', :number => 1, :dimension => dimensions_eja[7]},
                                    {:name => 'Assiduidade da equipe escolar', :number => 2, :dimension => dimensions_eja[7]},


                                    {:name => 'Existência de práticas alfabetizadoras na escola', :number => 1, :dimension => dimensions_eja[8]},
                                    {:name => 'Ampliação das capacidades de leitura e escrita dos educandos', :number => 2, :dimension => dimensions_eja[8]},
                                    {:name => 'Acesso e bom aproveitamento da biblioteca ou sala de leitura, dos equipamentos de informática e da internet', :number => 3, :dimension => dimensions_eja[8]}
                                    ])


indicators_creche = Indicator.create([{:name => 'Amizade e solidariedade', :number => 1, :dimension => dimensions_creche[0]},
                                    {:name => 'Alegria', :number => 2, :dimension => dimensions_creche[0]},
                                    {:name => 'Combate à discriminação', :number => 3, :dimension => dimensions_creche[0]},
                                    {:name => 'Mediação de conflitos', :number => 4, :dimension => dimensions_creche[0]},
                                    {:name => 'Respeito ao outro', :number => 5, :dimension => dimensions_creche[0]},
                                    {:name => 'Respeito aos direitos das crianças e dos adolescentes', :number => 6, :dimension => dimensions_creche[0]},
                                    {:name => 'Respeito à dignidade das crianças', :number => 7, :dimension => dimensions_creche[0]},
                                    {:name => 'Respeito à identidade, desejos e interesses das crianças', :number => 8, :dimension => dimensions_creche[0]},
                                    {:name => 'Respeito às ideias, conquistas e produções das crianças', :number => 9, :dimension => dimensions_creche[0]},
                                    {:name => 'Interação entre crianças e crianças', :number => 10, :dimension => dimensions_creche[0]},
                                    {:name => 'Respeito ao ritmo das crianças', :number => 11, :dimension => dimensions_creche[0]},

                                    {:name => 'Ambiente físico escolar', :number => 1, :dimension => dimensions_creche[1]},
                                    {:name => 'Espaços e mobiliários que favoreçam as experiências das crianças', :number => 2, :dimension => dimensions_creche[1]},
                                    {:name => 'Materiais variados e acessíveis às crianças', :number => 3, :dimension => dimensions_creche[1]},
                                    {:name => 'Espaços, materiais e mobiliários para responder aos interesses e necessidades dos adultos', :number => 4, :dimension => dimensions_creche[1]},

                                    {:name => 'Projeto Eco-Político-Pedagógico (PEPP) definido e conhecido por todos', :number => 1, :dimension => dimensions_creche[2]},
                                    {:name => 'Registro da prática educativa', :number => 2, :dimension => dimensions_creche[2]},
                                    {:name => 'Planejamento', :number => 3, :dimension => dimensions_creche[2]},
                                    {:name => 'Contextualização', :number => 4, :dimension => dimensions_creche[2]},
                                    {:name => 'Incentivo à autonomia e ao trabalho coletivo', :number => 5, :dimension => dimensions_creche[2]},
                                    {:name => 'Variedades das estratégias e dos recursos de ensino-aprendizagem', :number => 6, :dimension => dimensions_creche[2]},
                                    {:name => 'Prática pedagógica de apoio à diversidade', :number => 7, :dimension => dimensions_creche[2]},
                                    {:name => 'Multiplicidade de diferentes linguagens plásticas, simbólicas, musicais e corporais', :number => 8, :dimension => dimensions_creche[2]},
                                    {:name => 'Experiências e aproximação com a linguagem oral e escrita', :number => 9, :dimension => dimensions_creche[2]},
                                    {:name => 'Atuação do corpo técnico pedagógico (CTP)', :number => 10, :dimension => dimensions_creche[2]},

                                    {:name => 'Monitoramento do processo de aprendizagem dos educandos', :number => 1, :dimension => dimensions_creche[3]},
                                    {:name => 'Mecanismos de avaliação dos educandos', :number => 2, :dimension => dimensions_creche[3]},
                                    {:name => 'Participação dos educandos na avaliação de sua aprendizagem', :number => 3, :dimension => dimensions_creche[3]},
                                    {:name => 'Avaliação do trabalho dos profissionais da escola', :number => 4, :dimension => dimensions_creche[3]},
                                    {:name => 'Compartilhamento, reflexão e uso das avaliações educacionais da Rede Municipal de Ensino de Osasco', :number => 5, :dimension => dimensions_creche[3]},


                                    {:name => 'Atenção aos educandos com alguma defasagem de aprendizagem', :number => 1, :dimension => dimensions_creche[4]},
                                    {:name => 'Atenção às necessidades educativas da comunidade', :number => 2, :dimension => dimensions_creche[4]},
                                    {:name => 'Atenção especial aos educandos que faltam', :number => 3, :dimension => dimensions_creche[4]},

                                    {:name => 'Responsabilidade pela alimentação', :number => 1, :dimension => dimensions_creche[5]},
                                    {:name => 'Limpeza, salubridade e conforto', :number => 2, :dimension => dimensions_creche[5]},
                                    {:name => 'Segurança', :number => 3, :dimension => dimensions_creche[5]},
                                    {:name => 'Cuidados com a higiene e a saúde', :number => 4, :dimension => dimensions_creche[5]},

                                    {:name => 'Respeito a diversas formas de vida', :number => 1, :dimension => dimensions_creche[6]},
                                    {:name => 'Práticas ecopedagógicas', :number => 2, :dimension => dimensions_creche[6]},

                                    {:name => 'Respeito e acolhimento e envolvimento com as famílias', :number => 1, :dimension => dimensions_creche[7]},
                                    {:name => 'Garantia do direito das famílias de acompanhar as vivências e produções das crianças', :number => 2, :dimension => dimensions_creche[7]},
                                    {:name => 'Participação da escola na rede de proteção dos direitos das crianças', :number => 3, :dimension => dimensions_creche[7]},

                                    {:name => 'Democratização da gestão e informação', :number => 1, :dimension => dimensions_creche[8]},
                                    {:name => 'Conselhos atuantes', :number => 2, :dimension => dimensions_creche[8]},
                                    {:name => 'Parcerias locais e relacionamento da escola com os serviços públicos', :number => 3, :dimension => dimensions_creche[8]},


                                    {:name => 'Formação inicial e continuada', :number => 1, :dimension => dimensions_creche[9]},
                                    {:name => 'Suficiência da equipe escolar e condições de trabalho', :number => 2, :dimension => dimensions_creche[9]},
                                    {:name => 'Assiduidade da equipe escolar', :number => 3, :dimension => dimensions_creche[9]}

                                    ])

indicators_emei = Indicator.create([{:name => 'Amizade e solidariedade', :number => 1, :dimension => dimensions_emei[0]},
                                    {:name => 'Alegria', :number => 2, :dimension => dimensions_emei[0]},
                                    {:name => 'Combate à discriminação', :number => 3, :dimension => dimensions_emei[0]},
                                    {:name => 'Mediação de conflitos', :number => 4, :dimension => dimensions_emei[0]},
                                    {:name => 'Respeito ao outro', :number => 5, :dimension => dimensions_emei[0]},
                                    {:name => 'Respeito aos direitos das crianças e dos adolescentes', :number => 6, :dimension => dimensions_emei[0]},
                                    {:name => 'Respeito à dignidade das crianças', :number => 7, :dimension => dimensions_emei[0]},
                                    {:name => 'Respeito à identidade, desejos e interesses das crianças', :number => 8, :dimension => dimensions_emei[0]},
                                    {:name => 'Respeito às ideias, conquistas e produções das crianças', :number => 9, :dimension => dimensions_emei[0]},
                                    {:name => 'Interação entre crianças e crianças', :number => 10, :dimension => dimensions_emei[0]},
                                    {:name => 'Respeito ao ritmo das crianças', :number => 11, :dimension => dimensions_emei[0]},

                                    {:name => 'Ambiente físico escolar', :number => 1, :dimension => dimensions_emei[1]},
                                    {:name => 'Espaços e mobiliários que favoreçam as experiências das crianças', :number => 2, :dimension => dimensions_emei[1]},
                                    {:name => 'Materiais variados e acessíveis às crianças', :number => 3, :dimension => dimensions_emei[1]},
                                    {:name => 'Espaços, materiais e mobiliários para responder aos interesses e necessidades dos adultos', :number => 4, :dimension => dimensions_emei[1]},

                                    {:name => 'Projeto Eco-Político-Pedagógico (PEPP) definido e conhecido por todos', :number => 1, :dimension => dimensions_emei[2]},
                                    {:name => 'Registro da prática educativa', :number => 2, :dimension => dimensions_emei[2]},
                                    {:name => 'Planejamento', :number => 3, :dimension => dimensions_emei[2]},
                                    {:name => 'Contextualização', :number => 4, :dimension => dimensions_emei[2]},
                                    {:name => 'Incentivo à autonomia e ao trabalho coletivo', :number => 5, :dimension => dimensions_emei[2]},
                                    {:name => 'Variedades das estratégias e dos recursos de ensino-aprendizagem', :number => 6, :dimension => dimensions_emei[2]},
                                    {:name => 'Prática pedagógica de apoio à diversidade', :number => 7, :dimension => dimensions_emei[2]},
                                    {:name => 'Multiplicidade de diferentes linguagens plásticas, simbólicas, musicais e corporais', :number => 8, :dimension => dimensions_emei[2]},
                                    {:name => 'Experiências e aproximação com a linguagem oral e escrita', :number => 9, :dimension => dimensions_emei[2]},
                                    {:name => 'Atuação do corpo técnico pedagógico (CTP)', :number => 10, :dimension => dimensions_emei[2]},

                                    {:name => 'Monitoramento do processo de aprendizagem dos educandos', :number => 1, :dimension => dimensions_emei[3]},
                                    {:name => 'Mecanismos de avaliação dos educandos', :number => 2, :dimension => dimensions_emei[3]},
                                    {:name => 'Participação dos educandos na avaliação de sua aprendizagem', :number => 3, :dimension => dimensions_emei[3]},
                                    {:name => 'Avaliação do trabalho dos profissionais da escola', :number => 4, :dimension => dimensions_emei[3]},
                                    {:name => 'Compartilhamento, reflexão e uso das avaliações educacionais da Rede Municipal de Ensino de Osasco', :number => 5, :dimension => dimensions_emei[3]},


                                    {:name => 'Atenção aos educandos com alguma defasagem de aprendizagem', :number => 1, :dimension => dimensions_emei[4]},
                                    {:name => 'Atenção às necessidades educativas da comunidade', :number => 2, :dimension => dimensions_emei[4]},
                                    {:name => 'Atenção especial aos educandos que faltam', :number => 3, :dimension => dimensions_emei[4]},

                                    {:name => 'Responsabilidade pela alimentação', :number => 1, :dimension => dimensions_emei[5]},
                                    {:name => 'Limpeza, salubridade e conforto', :number => 2, :dimension => dimensions_emei[5]},
                                    {:name => 'Segurança', :number => 3, :dimension => dimensions_emei[5]},
                                    {:name => 'Cuidados com a higiene e a saúde', :number => 4, :dimension => dimensions_emei[5]},

                                    {:name => 'Respeito a diversas formas de vida', :number => 1, :dimension => dimensions_emei[6]},
                                    {:name => 'Práticas ecopedagógicas', :number => 2, :dimension => dimensions_emei[6]},

                                    {:name => 'Respeito e acolhimento e envolvimento com as famílias', :number => 1, :dimension => dimensions_emei[7]},
                                    {:name => 'Garantia do direito das famílias de acompanhar as vivências e produções das crianças', :number => 2, :dimension => dimensions_emei[7]},
                                    {:name => 'Participação da escola na rede de proteção dos direitos das crianças', :number => 3, :dimension => dimensions_emei[7]},

                                    {:name => 'Democratização da gestão e informação', :number => 1, :dimension => dimensions_emei[8]},
                                    {:name => 'Conselhos atuantes', :number => 2, :dimension => dimensions_emei[8]},
                                    {:name => 'Parcerias locais e relacionamento da escola com os serviços públicos', :number => 3, :dimension => dimensions_emei[8]},


                                    {:name => 'Formação inicial e continuada', :number => 1, :dimension => dimensions_emei[9]},
                                    {:name => 'Suficiência da equipe escolar e condições de trabalho', :number => 2, :dimension => dimensions_emei[9]},
                                    {:name => 'Assiduidade da equipe escolar', :number => 3, :dimension => dimensions_emei[9]}

                                    ])


indicators_emef = Indicator.create([{:name => 'Amizade e solidariedade', :number => 1, :dimension => dimensions_emef[0]},
                                    {:name => 'Alegria', :number => 2, :dimension => dimensions_emef[0]},
                                    {:name => 'Combate à discriminação', :number => 3, :dimension => dimensions_emef[0]},
                                    {:name => 'Mediação de conflitos', :number => 4, :dimension => dimensions_emef[0]},
                                    {:name => 'Respeito ao outro', :number => 5, :dimension => dimensions_emef[0]},
                                    {:name => 'Respeito aos direitos das crianças e dos adolescentes', :number => 6, :dimension => dimensions_emef[0]},
                                    {:name => 'Respeito à dignidade das crianças', :number => 7, :dimension => dimensions_emef[0]},
                                    {:name => 'Respeito à identidade, desejos e interesses das crianças', :number => 8, :dimension => dimensions_emef[0]},
                                    {:name => 'Respeito às ideias, conquistas e produções das crianças', :number => 9, :dimension => dimensions_emef[0]},
                                    {:name => 'Interação entre crianças e crianças', :number => 10, :dimension => dimensions_emef[0]},

                                    {:name => 'Ambiente físico escolar', :number => 1, :dimension => dimensions_emef[1]},
                                    {:name => 'Espaços e mobiliários que favoreçam as experiências das crianças', :number => 2, :dimension => dimensions_emef[1]},
                                    {:name => 'Materiais variados e acessíveis às crianças', :number => 3, :dimension => dimensions_emef[1]},
                                    {:name => 'Espaços, materiais e mobiliários para responder aos interesses e necessidades dos adultos', :number => 4, :dimension => dimensions_emef[1]},

                                    {:name => 'Projeto Eco-Político-Pedagógico (PEPP) definido e conhecido por todos', :number => 1, :dimension => dimensions_emef[2]},
                                    {:name => 'Registro da prática educativa', :number => 2, :dimension => dimensions_emef[2]},
                                    {:name => 'Planejamento', :number => 3, :dimension => dimensions_emef[2]},
                                    {:name => 'Contextualização', :number => 4, :dimension => dimensions_emef[2]},
                                    {:name => 'Incentivo à autonomia e ao trabalho coletivo', :number => 5, :dimension => dimensions_emef[2]},
                                    {:name => 'Variedades das estratégias e dos recursos de ensino-aprendizagem', :number => 6, :dimension => dimensions_emef[2]},
                                    {:name => 'Prática pedagógica de apoio à diversidade', :number => 7, :dimension => dimensions_emef[2]},
                                    {:name => 'Multiplicidade de diferentes linguagens plásticas, simbólicas, musicais e corporais', :number => 8, :dimension => dimensions_emef[2]},
                                    {:name => 'Atuação do corpo técnico pedagógico (CTP)', :number => 9, :dimension => dimensions_emef[2]},

                                    {:name => 'Monitoramento do processo de aprendizagem dos educandos', :number => 1, :dimension => dimensions_emef[3]},
                                    {:name => 'Mecanismos de avaliação', :number => 2, :dimension => dimensions_emef[3]},
                                    {:name => 'Participação dos educandos na avaliação de sua aprendizagem', :number => 3, :dimension => dimensions_emef[3]},
                                    {:name => 'Avaliação do trabalho dos profissionais da escola', :number => 4, :dimension => dimensions_emef[3]},
                                    {:name => 'Compartilhamento, reflexão e uso das avaliações educacionais da Rede Municipal de Ensino de Osasco', :number => 5, :dimension => dimensions_emef[3]},
                                    {:name => 'Acesso, compreensão e uso dos indicadores oficiais de avaliação do MEC', :number => 6, :dimension => dimensions_emef[3]},

                                    {:name => 'Atenção aos educandos com alguma defasagem de aprendizagem', :number => 1, :dimension => dimensions_emef[4]},
                                    {:name => 'Atenção às necessidades educativas da comunidade', :number => 2, :dimension => dimensions_emef[4]},
                                    {:name => 'Atenção especial aos educandos que faltam', :number => 3, :dimension => dimensions_emef[4]},
                                    {:name => 'Preocupação com o abandono e evasão', :number => 4, :dimension => dimensions_emef[4]},

                                    {:name => 'Responsabilidade pela alimentação', :number => 1, :dimension => dimensions_emef[5]},
                                    {:name => 'Limpeza, salubridade e conforto', :number => 2, :dimension => dimensions_emef[5]},
                                    {:name => 'Segurança', :number => 3, :dimension => dimensions_emef[5]},
                                    {:name => 'Cuidados com a higiene e a saúde', :number => 4, :dimension => dimensions_emef[5]},

                                    {:name => 'Respeito a diversas formas de vida', :number => 1, :dimension => dimensions_emef[6]},
                                    {:name => 'Práticas ecopedagógicas', :number => 2, :dimension => dimensions_emef[6]},

                                    {:name => 'Respeito e acolhimento e envolvimento com as famílias', :number => 1, :dimension => dimensions_emef[7]},
                                    {:name => 'Garantia do direito das famílias de acompanhar as vivências e produções das crianças', :number => 2, :dimension => dimensions_emef[7]},
                                    {:name => 'Participação da escola na rede de proteção dos direitos das crianças', :number => 3, :dimension => dimensions_emef[7]},

                                    {:name => 'Democratização da gestão e informação', :number => 1, :dimension => dimensions_emef[8]},
                                    {:name => 'Conselhos atuantes', :number => 2, :dimension => dimensions_emef[8]},
                                    {:name => 'Parcerias locais e relacionamento da escola com os serviços públicos', :number => 3, :dimension => dimensions_emef[8]},
                                    {:name => 'Participação efetiva de educandos, pais, responsáveis e comunidade em geral', :number => 4, :dimension => dimensions_emef[8]},

                                    {:name => 'Formação inicial e continuada', :number => 1, :dimension => dimensions_emef[9]},
                                    {:name => 'Suficiência da equipe escolar e condições de trabalho', :number => 2, :dimension => dimensions_emef[9]},
                                    {:name => 'Assiduidade da equipe escolar', :number => 3, :dimension => dimensions_emef[9]},

                                    {:name => 'Orientações para a alfabetização inicial implementadas', :number => 1, :dimension => dimensions_emef[10]},
                                    {:name => 'Existência de práticas alfabetizadoras na escola', :number => 2, :dimension => dimensions_emef[10]},
                                    {:name => 'Atenção ao processo de alfabetização de cada criança', :number => 3, :dimension => dimensions_emef[10]},
                                    {:name => 'Ampliação das capacidades de leitura e escrita dos educandos ao longo do ensino fundamental', :number => 4, :dimension => dimensions_emef[10]},
                                    {:name => 'Acesso e bom aproveitamento da biblioteca ou sala de leitura', :number => 5, :dimension => dimensions_emef[10]}
                                    ])

indicators_conveniada = Indicator.create([{:name => 'Amizade e solidariedade', :number => 1, :dimension => dimensions_conveniada[0]},
                                    {:name => 'Alegria', :number => 2, :dimension => dimensions_conveniada[0]},
                                    {:name => 'Combate à discriminação', :number => 3, :dimension => dimensions_conveniada[0]},
                                    {:name => 'Mediação de conflitos', :number => 4, :dimension => dimensions_conveniada[0]},
                                    {:name => 'Respeito ao outro', :number => 5, :dimension => dimensions_conveniada[0]},
                                    {:name => 'Respeito aos direitos das crianças e dos adolescentes', :number => 6, :dimension => dimensions_conveniada[0]},
                                    {:name => 'Respeito à dignidade das crianças', :number => 7, :dimension => dimensions_conveniada[0]},
                                    {:name => 'Respeito à identidade, desejos e interesses das crianças', :number => 8, :dimension => dimensions_conveniada[0]},
                                    {:name => 'Respeito às ideias, conquistas e produções das crianças', :number => 9, :dimension => dimensions_conveniada[0]},
                                    {:name => 'Interação entre crianças e crianças', :number => 10, :dimension => dimensions_conveniada[0]},
                                    {:name => 'Respeito ao ritmo das crianças', :number => 11, :dimension => dimensions_conveniada[0]},

                                    {:name => 'Ambiente físico escolar', :number => 1, :dimension => dimensions_conveniada[1]},
                                    {:name => 'Espaços e mobiliários que favoreçam as experiências das crianças', :number => 2, :dimension => dimensions_conveniada[1]},
                                    {:name => 'Materiais variados e acessíveis às crianças', :number => 3, :dimension => dimensions_conveniada[1]},
                                    {:name => 'Espaços, materiais e mobiliários para responder aos interesses e necessidades dos adultos', :number => 4, :dimension => dimensions_conveniada[1]},

                                    {:name => 'Projeto Eco-Político-Pedagógico (PEPP) definido e conhecido por todos', :number => 1, :dimension => dimensions_conveniada[2]},
                                    {:name => 'Registro da prática educativa', :number => 2, :dimension => dimensions_conveniada[2]},
                                    {:name => 'Planejamento', :number => 3, :dimension => dimensions_conveniada[2]},
                                    {:name => 'Contextualização', :number => 4, :dimension => dimensions_conveniada[2]},
                                    {:name => 'Incentivo à autonomia e ao trabalho coletivo', :number => 5, :dimension => dimensions_conveniada[2]},
                                    {:name => 'Variedades das estratégias e dos recursos de ensino-aprendizagem', :number => 6, :dimension => dimensions_conveniada[2]},
                                    {:name => 'Prática pedagógica de apoio à diversidade', :number => 7, :dimension => dimensions_conveniada[2]},
                                    {:name => 'Multiplicidade de diferentes linguagens plásticas, simbólicas, musicais e corporais', :number => 8, :dimension => dimensions_conveniada[2]},
                                    {:name => 'Experiências e aproximação com a linguagem oral e escrita', :number => 9, :dimension => dimensions_conveniada[2]},
                                    {:name => 'Atuação do corpo técnico pedagógico (CTP)', :number => 10, :dimension => dimensions_conveniada[2]},

                                    {:name => 'Monitoramento do processo de aprendizagem dos educandos', :number => 1, :dimension => dimensions_conveniada[3]},
                                    {:name => 'Mecanismos de avaliação dos educandos', :number => 2, :dimension => dimensions_conveniada[3]},
                                    {:name => 'Participação dos educandos na avaliação de sua aprendizagem', :number => 3, :dimension => dimensions_conveniada[3]},
                                    {:name => 'Avaliação do trabalho dos profissionais da escola', :number => 4, :dimension => dimensions_conveniada[3]},
                                    {:name => 'Compartilhamento, reflexão e uso das avaliações educacionais da Rede Municipal de Ensino de Osasco', :number => 5, :dimension => dimensions_conveniada[3]},


                                    {:name => 'Atenção aos educandos com alguma defasagem de aprendizagem', :number => 1, :dimension => dimensions_conveniada[4]},
                                    {:name => 'Atenção às necessidades educativas da comunidade', :number => 2, :dimension => dimensions_conveniada[4]},
                                    {:name => 'Atenção especial aos educandos que faltam', :number => 3, :dimension => dimensions_conveniada[4]},

                                    {:name => 'Responsabilidade pela alimentação', :number => 1, :dimension => dimensions_conveniada[5]},
                                    {:name => 'Limpeza, salubridade e conforto', :number => 2, :dimension => dimensions_conveniada[5]},
                                    {:name => 'Segurança', :number => 3, :dimension => dimensions_conveniada[5]},
                                    {:name => 'Cuidados com a higiene e a saúde', :number => 4, :dimension => dimensions_conveniada[5]},

                                    {:name => 'Respeito a diversas formas de vida', :number => 1, :dimension => dimensions_conveniada[6]},
                                    {:name => 'Práticas ecopedagógicas', :number => 2, :dimension => dimensions_conveniada[6]},

                                    {:name => 'Respeito e acolhimento e envolvimento com as famílias', :number => 1, :dimension => dimensions_conveniada[7]},
                                    {:name => 'Garantia do direito das famílias de acompanhar as vivências e produções das crianças', :number => 2, :dimension => dimensions_conveniada[7]},
                                    {:name => 'Participação da escola na rede de proteção dos direitos das crianças', :number => 3, :dimension => dimensions_conveniada[7]},

                                    {:name => 'Democratização da gestão e informação', :number => 1, :dimension => dimensions_conveniada[8]},
                                    {:name => 'Conselhos atuantes', :number => 2, :dimension => dimensions_conveniada[8]},
                                    {:name => 'Parcerias locais e relacionamento da escola com os serviços públicos', :number => 3, :dimension => dimensions_conveniada[8]},


                                    {:name => 'Formação inicial e continuada', :number => 1, :dimension => dimensions_conveniada[9]},
                                    {:name => 'Suficiência da equipe escolar e condições de trabalho', :number => 2, :dimension => dimensions_conveniada[9]},
                                    {:name => 'Assiduidade da equipe escolar', :number => 3, :dimension => dimensions_conveniada[9]}

                                    ])



# Sorocaba

# indicators_em = Indicator.create([{:name => 'Amizade e solidariedade', :number => 1, :dimension => dimensions_em[0]},
#                                     {:name => 'Alegria', :number => 2, :dimension => dimensions_em[0]},
#                                     {:name => 'Combate à discriminação', :number => 3, :dimension => dimensions_em[0]},
#                                     {:name => 'Mediação de conflitos', :number => 4, :dimension => dimensions_em[0]},
#                                     {:name => 'Respeito ao outro', :number => 5, :dimension => dimensions_em[0]},
#                                     {:name => 'Respeito aos direitos das crianças e dos adolescentes', :number => 6, :dimension => dimensions_em[0]},
#                                     {:name => 'Respeito à dignidade das crianças', :number => 7, :dimension => dimensions_em[0]},
#                                     {:name => 'Respeito à identidade, desejos e interesses das crianças', :number => 8, :dimension => dimensions_em[0]},
#                                     {:name => 'Respeito às ideias, conquistas e produções das crianças', :number => 9, :dimension => dimensions_em[0]},
#                                     {:name => 'Interação entre crianças e crianças', :number => 10, :dimension => dimensions_em[0]},

#                                     {:name => 'Ambiente físico escolar', :number => 1, :dimension => dimensions_em[1]},
#                                     {:name => 'Espaços e mobiliários que favoreçam as experiências das crianças', :number => 2, :dimension => dimensions_em[1]},
#                                     {:name => 'Materiais variados e acessíveis às crianças', :number => 3, :dimension => dimensions_em[1]},
#                                     {:name => 'Espaços, materiais e mobiliários para responder aos interesses e necessidades dos adultos', :number => 4, :dimension => dimensions_em[1]},

#                                     {:name => 'Projeto Eco-Político-Pedagógico (PEPP) definido e conhecido por todos', :number => 1, :dimension => dimensions_em[2]},
#                                     {:name => 'Registro da prática educativa', :number => 2, :dimension => dimensions_em[2]},
#                                     {:name => 'Planejamento', :number => 3, :dimension => dimensions_em[2]},
#                                     {:name => 'Contextualização', :number => 4, :dimension => dimensions_em[2]},
#                                     {:name => 'Incentivo à autonomia e ao trabalho coletivo', :number => 5, :dimension => dimensions_em[2]},
#                                     {:name => 'Variedades das estratégias e dos recursos de ensino-aprendizagem', :number => 6, :dimension => dimensions_em[2]},
#                                     {:name => 'Prática pedagógica de apoio à diversidade', :number => 7, :dimension => dimensions_em[2]},
#                                     {:name => 'Multiplicidade de diferentes linguagens plásticas, simbólicas, musicais e corporais', :number => 8, :dimension => dimensions_em[2]},
#                                     {:name => 'Atuação do corpo técnico pedagógico (CTP)', :number => 9, :dimension => dimensions_em[2]},

#                                     {:name => 'Monitoramento do processo de aprendizagem dos educandos', :number => 1, :dimension => dimensions_em[3]},
#                                     {:name => 'Mecanismos de avaliação', :number => 2, :dimension => dimensions_em[3]},
#                                     {:name => 'Participação dos educandos na avaliação de sua aprendizagem', :number => 3, :dimension => dimensions_em[3]},
#                                     {:name => 'Avaliação do trabalho dos profissionais da escola', :number => 4, :dimension => dimensions_em[3]},
#                                     {:name => 'Compartilhamento, reflexão e uso das avaliações educacionais da Rede Municipal de Ensino de Osasco', :number => 5, :dimension => dimensions_em[3]},
#                                     {:name => 'Acesso, compreensão e uso dos indicadores oficiais de avaliação do MEC', :number => 6, :dimension => dimensions_em[3]},

#                                     {:name => 'Atenção aos educandos com alguma defasagem de aprendizagem', :number => 1, :dimension => dimensions_em[4]},
#                                     {:name => 'Atenção às necessidades educativas da comunidade', :number => 2, :dimension => dimensions_em[4]},
#                                     {:name => 'Atenção especial aos educandos que faltam', :number => 3, :dimension => dimensions_em[4]},
#                                     {:name => 'Preocupação com o abandono e evasão', :number => 4, :dimension => dimensions_em[4]},

#                                     {:name => 'Responsabilidade pela alimentação', :number => 1, :dimension => dimensions_em[5]},
#                                     {:name => 'Limpeza, salubridade e conforto', :number => 2, :dimension => dimensions_em[5]},
#                                     {:name => 'Segurança', :number => 3, :dimension => dimensions_em[5]},
#                                     {:name => 'Cuidados com a higiene e a saúde', :number => 4, :dimension => dimensions_em[5]},

#                                     {:name => 'Respeito a diversas formas de vida', :number => 1, :dimension => dimensions_em[6]},
#                                     {:name => 'Práticas ecopedagógicas', :number => 2, :dimension => dimensions_em[6]},

#                                     {:name => 'Respeito e acolhimento e envolvimento com as famílias', :number => 1, :dimension => dimensions_em[7]},
#                                     {:name => 'Garantia do direito das famílias de acompanhar as vivências e produções das crianças', :number => 2, :dimension => dimensions_em[7]},
#                                     {:name => 'Participação da escola na rede de proteção dos direitos das crianças', :number => 3, :dimension => dimensions_em[7]},

#                                     {:name => 'Democratização da gestão e informação', :number => 1, :dimension => dimensions_em[8]},
#                                     {:name => 'Conselhos atuantes', :number => 2, :dimension => dimensions_em[8]},
#                                     {:name => 'Parcerias locais e relacionamento da escola com os serviços públicos', :number => 3, :dimension => dimensions_em[8]},
#                                     {:name => 'Participação efetiva de educandos, pais, responsáveis e comunidade em geral', :number => 4, :dimension => dimensions_em[8]},

#                                     {:name => 'Formação inicial e continuada', :number => 1, :dimension => dimensions_em[9]},
#                                     {:name => 'Suficiência da equipe escolar e condições de trabalho', :number => 2, :dimension => dimensions_em[9]},
#                                     {:name => 'Assiduidade da equipe escolar', :number => 3, :dimension => dimensions_em[9]},

#                                     {:name => 'Orientações para a alfabetização inicial implementadas', :number => 1, :dimension => dimensions_em[10]},
#                                     {:name => 'Existência de práticas alfabetizadoras na escola', :number => 2, :dimension => dimensions_em[10]},
#                                     {:name => 'Atenção ao processo de alfabetização de cada criança', :number => 3, :dimension => dimensions_em[10]},
#                                     {:name => 'Ampliação das capacidades de leitura e escrita dos educandos ao longo do ensino fundamental', :number => 4, :dimension => dimensions_em[10]},
#                                     {:name => 'Acesso e bom aproveitamento da biblioteca ou sala de leitura', :number => 5, :dimension => dimensions_em[10]}
#                                     ])


# indicators_emeif = Indicator.create([{:name => 'Amizade e solidariedade', :number => 1, :dimension => dimensions_em[0]},
#                                     {:name => 'Alegria', :number => 2, :dimension => dimensions_em[0]},
#                                     {:name => 'Combate à discriminação', :number => 3, :dimension => dimensions_em[0]},
#                                     {:name => 'Mediação de conflitos', :number => 4, :dimension => dimensions_em[0]},
#                                     {:name => 'Respeito ao outro', :number => 5, :dimension => dimensions_em[0]},
#                                     {:name => 'Respeito aos direitos das crianças e dos adolescentes', :number => 6, :dimension => dimensions_em[0]},
#                                     {:name => 'Respeito à dignidade das crianças', :number => 7, :dimension => dimensions_em[0]},
#                                     {:name => 'Respeito à identidade, desejos e interesses das crianças', :number => 8, :dimension => dimensions_em[0]},
#                                     {:name => 'Respeito às ideias, conquistas e produções das crianças', :number => 9, :dimension => dimensions_em[0]},
#                                     {:name => 'Interação entre crianças e crianças', :number => 10, :dimension => dimensions_em[0]},

#                                     {:name => 'Ambiente físico escolar', :number => 1, :dimension => dimensions_em[1]},
#                                     {:name => 'Espaços e mobiliários que favoreçam as experiências das crianças', :number => 2, :dimension => dimensions_em[1]},
#                                     {:name => 'Materiais variados e acessíveis às crianças', :number => 3, :dimension => dimensions_em[1]},
#                                     {:name => 'Espaços, materiais e mobiliários para responder aos interesses e necessidades dos adultos', :number => 4, :dimension => dimensions_em[1]},

#                                     {:name => 'Projeto Eco-Político-Pedagógico (PEPP) definido e conhecido por todos', :number => 1, :dimension => dimensions_em[2]},
#                                     {:name => 'Registro da prática educativa', :number => 2, :dimension => dimensions_em[2]},
#                                     {:name => 'Planejamento', :number => 3, :dimension => dimensions_em[2]},
#                                     {:name => 'Contextualização', :number => 4, :dimension => dimensions_em[2]},
#                                     {:name => 'Incentivo à autonomia e ao trabalho coletivo', :number => 5, :dimension => dimensions_em[2]},
#                                     {:name => 'Variedades das estratégias e dos recursos de ensino-aprendizagem', :number => 6, :dimension => dimensions_em[2]},
#                                     {:name => 'Prática pedagógica de apoio à diversidade', :number => 7, :dimension => dimensions_em[2]},
#                                     {:name => 'Multiplicidade de diferentes linguagens plásticas, simbólicas, musicais e corporais', :number => 8, :dimension => dimensions_em[2]},
#                                     {:name => 'Atuação do corpo técnico pedagógico (CTP)', :number => 9, :dimension => dimensions_em[2]},

#                                     {:name => 'Monitoramento do processo de aprendizagem dos educandos', :number => 1, :dimension => dimensions_em[3]},
#                                     {:name => 'Mecanismos de avaliação', :number => 2, :dimension => dimensions_em[3]},
#                                     {:name => 'Participação dos educandos na avaliação de sua aprendizagem', :number => 3, :dimension => dimensions_em[3]},
#                                     {:name => 'Avaliação do trabalho dos profissionais da escola', :number => 4, :dimension => dimensions_em[3]},
#                                     {:name => 'Compartilhamento, reflexão e uso das avaliações educacionais da Rede Municipal de Ensino de Osasco', :number => 5, :dimension => dimensions_em[3]},
#                                     {:name => 'Acesso, compreensão e uso dos indicadores oficiais de avaliação do MEC', :number => 6, :dimension => dimensions_em[3]},

#                                     {:name => 'Atenção aos educandos com alguma defasagem de aprendizagem', :number => 1, :dimension => dimensions_em[4]},
#                                     {:name => 'Atenção às necessidades educativas da comunidade', :number => 2, :dimension => dimensions_em[4]},
#                                     {:name => 'Atenção especial aos educandos que faltam', :number => 3, :dimension => dimensions_em[4]},
#                                     {:name => 'Preocupação com o abandono e evasão', :number => 4, :dimension => dimensions_em[4]},

#                                     {:name => 'Responsabilidade pela alimentação', :number => 1, :dimension => dimensions_em[5]},
#                                     {:name => 'Limpeza, salubridade e conforto', :number => 2, :dimension => dimensions_em[5]},
#                                     {:name => 'Segurança', :number => 3, :dimension => dimensions_em[5]},
#                                     {:name => 'Cuidados com a higiene e a saúde', :number => 4, :dimension => dimensions_em[5]},

#                                     {:name => 'Respeito a diversas formas de vida', :number => 1, :dimension => dimensions_em[6]},
#                                     {:name => 'Práticas ecopedagógicas', :number => 2, :dimension => dimensions_em[6]},

#                                     {:name => 'Respeito e acolhimento e envolvimento com as famílias', :number => 1, :dimension => dimensions_em[7]},
#                                     {:name => 'Garantia do direito das famílias de acompanhar as vivências e produções das crianças', :number => 2, :dimension => dimensions_em[7]},
#                                     {:name => 'Participação da escola na rede de proteção dos direitos das crianças', :number => 3, :dimension => dimensions_em[7]},

#                                     {:name => 'Democratização da gestão e informação', :number => 1, :dimension => dimensions_em[8]},
#                                     {:name => 'Conselhos atuantes', :number => 2, :dimension => dimensions_em[8]},
#                                     {:name => 'Parcerias locais e relacionamento da escola com os serviços públicos', :number => 3, :dimension => dimensions_em[8]},
#                                     {:name => 'Participação efetiva de educandos, pais, responsáveis e comunidade em geral', :number => 4, :dimension => dimensions_em[8]},

#                                     {:name => 'Formação inicial e continuada', :number => 1, :dimension => dimensions_em[9]},
#                                     {:name => 'Suficiência da equipe escolar e condições de trabalho', :number => 2, :dimension => dimensions_em[9]},
#                                     {:name => 'Assiduidade da equipe escolar', :number => 3, :dimension => dimensions_em[9]},

#                                     {:name => 'Orientações para a alfabetização inicial implementadas', :number => 1, :dimension => dimensions_em[10]},
#                                     {:name => 'Existência de práticas alfabetizadoras na escola', :number => 2, :dimension => dimensions_em[10]},
#                                     {:name => 'Atenção ao processo de alfabetização de cada criança', :number => 3, :dimension => dimensions_em[10]},
#                                     {:name => 'Ampliação das capacidades de leitura e escrita dos educandos ao longo do ensino fundamental', :number => 4, :dimension => dimensions_em[10]},
#                                     {:name => 'Acesso e bom aproveitamento da biblioteca ou sala de leitura', :number => 5, :dimension => dimensions_em[10]}
#                                     ])

# School.create([{:name => "CEI 02 Marina Grohmann, Profª", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 03 Zizi de Almeida, Dona", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 05 Antonio Amábile", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 07 Francisca Moura Pereira da Silva", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 08 Messias Ribeiro de Noronha Cunha, Profº", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 09 Fernando Rios, Prof.", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 10 Eglatina Rocco Perli", :service_levels => [levels[EMEI],levels[EMEF]]},
#       {:name => "CEI 11 Tercília Freire, Dona", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 13 Aluisio de Almeida", :service_levels => [levels[EMEI],levels[EMEF]]},
#       {:name => "CEI 14 Carlos Reinaldo Mendes, Eng°", :service_levels => [levels[EMEI],levels[EMEF]]},
#       {:name => "CEI 15 Terezinha Lucas Fernandes, Profª", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 16 Beatriz de Moraes Leite Fogaça, Profª", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 17 Issa Latuf", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 18 Miguel Cheda", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 20 Victória Salus Lara", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 21 Aureliano Rodrigues", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 22 Victor Pedroso, Dr.", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 23 Dolores Cupiam do Amaral", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 25 Jorge Frederico Scherepel", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 26 Luiz de Sanctis", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 27 Christina dos Reis, Profª", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 28 Rauldinéia Esteves Machado", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 30 Maria Pedroso Bellotti", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 31 Victoria Haddad Sayeg", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 34 Alberto Grosso", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 35 Maria Ondina Soares Vial Brunetto", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 36 Abney Medeiros Carneiro, Drª", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 38 Maria Garcia Vecina", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 39 Sha'ar Hanegev", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 40 Duzolina Batiolla Pagliato, Dona", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 41 Antonio Fratti", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 43 Vera Lúcia Momesso Maldonado, Profª", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 44 Luiz Ribeiro", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 45 Diva Ferreira Cordeiro", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 46 Ernesto Martins", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 47 Betty Souza Oliveira, Profª", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 48 Achilles Kloeckner, Frei", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 50 Alípio Guerra da Cunha, Profº", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 51 Rubens Vieira", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 52 Olga Chibau Fornazieiro", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 53 Benjamin Felipe Grizzi", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 54 Sônia Aparecida Machado", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 57 João Salerno, Engº", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 58 Dulce Puppo de Oliveira Pinheiros, Profª", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 59 Eugênio Leite", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 60 Anna Rusconi", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 61 Yolanda Rizzo", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 62 Antônio Simon Sola, Monsenhor", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 63 Reynaldo D'Alessandro", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 64 Joana Simon Sola", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 65 Santo Agostinho", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 66 Frat. Feminina Cruzeiro do Sul", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 67 Maria das Graças A P Nardi, Profª", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 68 Gladys Moeckel de Togni Amaral", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 69 Ester Bueno de Camargo Nascimento, Profª", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 70 Adail Odin Arruda, Profº", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 71 Yolanda Prestes Neder, Profª", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 72 Sueli Gazzolli Campos, Profª", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 73 Matilde Gavin", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 74 Maria de Castro Affonso Marins, Profª", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 75 Alcir Guedes Ribeiro, Jornalista", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 76 Menino Jesus", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 77 Olga de Toledo Lara, Profª", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 78 Ettore Marangoni", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 79 João Tortello, Prof.", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 80 - Ana Rosa Judice Moreira Zanussi de Oliveira, Profª", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 81 Edith Del Cistia Santos, Profª", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 82 Benedito Marçal – Didi, Prof.", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 83 Maria Carmen Rodrigues Sacker", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 84 Osmar de Almeida", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 85 Maria Regina A. Godoy", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 86 Jorge Luís Prestes Del Cistia", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 87 Cássio Rosa, Dr.", :service_levels => [levels[EMEI]]},
#       {:name => "CEI 88 Vera Apparecida Guariglia dos Santos, Profª", :service_levels => [levels[EMEI]]},

#       {:name => "Ary de Oliveira Seabra", :service_levels => [levels[EMEI], levels[EMEF]]},
#       {:name => "Avelino Leite de Camargo", :service_levels => [levels[EMEI], levels[EMEF]]},
#       {:name => "Duljara F. de Oliveira", :service_levels => [levels[EMEI], levels[EMEF]]},
#       {:name => "Genny Kalil Milego", :service_levels => [levels[EMEI], levels[EMEF]]},
#       {:name => "Inêz Rodrigues Cesarotti", :service_levels => [levels[EMEI], levels[EMEF]]},
#       {:name => "José Mendes", :service_levels => [levels[EMEI], levels[EMEF]]},
#       {:name => "Léa Edy Alonso Saliba, Profª", :service_levels => [levels[EMEI], levels[EMEF]]},
#       {:name => "Maria de Lourdes Ayres de Moraes, Profª", :service_levels => [levels[EMEI], levels[EMEF]]},
#       {:name => "Maria Domingas Tótora de Góes", :service_levels => [levels[EMEI], levels[EMEF]]},
#       {:name => "Maria Ignez Figueiredo Deluno, Profª", :service_levels => [levels[EMEI], levels[EMEF]]},
#       {:name => "Norma Justa Dall'Ara, Profª", :service_levels => [levels[EMEI], levels[EMEF]]},
#       {:name => "Oswaldo Duarte", :service_levels => [levels[EMEI], levels[EMEF]]},
#       {:name => "Paulo Fernando Nóbrega Tortello", :service_levels => [levels[EMEI], levels[EMEF]]},
#       {:name => "Tereza Ciambelli Gianni", :service_levels => [levels[EMEI], levels[EMEF]]},
#       {:name => "Walter Carretero", :service_levels => [levels[EMEI], levels[EMEF]]},
#       {:name => "João Francisco Rosa", :service_levels => [levels[EMEI], levels[EMEF]]},
#       {:name => "Quinzinho de Barros", :service_levels => [levels[EMEI], levels[EMEF]]},
#       {:name => "Rosa Cury", :service_levels => [levels[EMEI], levels[EMEF]]},
#       {:name => "Julica Bierrenbach,Profª", :service_levels => [levels[EMEF]]},
#       {:name => "Matheus Maylasky", :service_levels => [levels[EMEF]]},
#       {:name => "Sorocaba-Leste", :service_levels => [levels[EMEF]]},

#       {:name => "GENEBRA", :service_levels => [levels[EMEF]]},
#       {:name => "Basílio da Costa Daemon", :service_levels => [levels[EMEF]]},
#       {:name => "Benedicto José Nunes", :service_levels => [levels[EMEF]]},
#       {:name => "Darlene Devasto", :service_levels => [levels[EMEF]]},
#       {:name => "Edemir Antonio Digiampietri", :service_levels => [levels[EMEF]]},
#       {:name => "Edward F. Marciano da Silva", :service_levels => [levels[EMEF]]},
#       {:name => "Hélio Rosa Baldy", :service_levels => [levels[EMEF]]},
#       {:name => "Irineu Leister", :service_levels => [levels[EMEF]]},
#       {:name => "Josefina Zilia de Carvalho", :service_levels => [levels[EMEF]]},
#       {:name => "Luiz de Almeida Marins", :service_levels => [levels[EMEF]]},
#       {:name => "Mª de Lourdes M. Martinez", :service_levels => [levels[EMEF]]},
#       {:name => "Oswaldo de Oliveira", :service_levels => [levels[EMEF]]},
#       {:name => "Zilah Dias de Mello Schrepel", :service_levels => [levels[EMEF]]},
#       {:name => "Achilles de Almeida", :service_levels => [levels[EMEF], levels[ENSINO_MEDIO]]},
#       {:name => "Flávio de Souza Nogueira", :service_levels => [levels[EMEF], levels[ENSINO_MEDIO]]},
#       {:name => "Getúlio Vargas", :service_levels => [levels[EMEF], levels[ENSINO_MEDIO]]},
#       {:name => "Leonor Pinto Thomaz", :service_levels => [levels[EMEF], levels[ENSINO_MEDIO]]}
#       ]
# )

































