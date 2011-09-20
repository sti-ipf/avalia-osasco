# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
admin = AdminUser.create(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')

levels = ServiceLevel.create([{:name => "CRECHE"}, {:name => "EMEI"}, {:name => "EMEF"}, {:name => "EJA"}, {:name => "BURJATO"}, {:name => "CRECHE CONVENIADA"}])


# Criação das Creches
schools_creche = School.create([{:name => "CRECHE ALHA ELIAS ABIBE", :service_levels => [levels[0]]},
                              {:name => "CRECHE ALZIRA SILVA MEDEIROS", :service_levels => [levels[0]]},
                              {:name => "CRECHE AMELIA TOZZETO VIVIANE", :service_levels => [levels[0]]},
                              {:name => "CRECHE BENEDITA DE OLIVEIRA", :service_levels => [levels[0]]},
                              {:name => "CRECHE DAISY RIBEIRO NEVES", :service_levels => [levels[0]]},
                              {:name => "CRECHE ELZA BATISTON", :service_levels => [levels[0]]},
                              {:name => "CRECHE EZIO MELLI", :service_levels => [levels[0]]},
                              {:name => "CRECHE GIUSEPPA BERSANI MICHELIN", :service_levels => [levels[0]]},
                              {:name => "CRECHE HERMINIA LOPES", :service_levels => [levels[0]]},
                              {:name => "CRECHE HILDA ALVES DOS SANTOS MARIM", :service_levels => [levels[0]]},
                              {:name => "CRECHE IDA BELMONTE BISCUOLA", :service_levels => [levels[0]]},
                              {:name => "CRECHE INES SANCHES MENDES", :service_levels => [levels[0]]},
                              {:name => "CRECHE JOAO CORREA", :service_levels => [levels[0]]},
                              {:name => "CRECHE JOAQUINA FRANCA GARCIA, PROFa", :service_levels => [levels[0]]},
                              {:name => "CRECHE JOSE ESPINOSA", :service_levels => [levels[0]]},
                              {:name => "CRECHE JOSE CARLOS DI MAMBRO, PE.", :service_levels => [levels[0]]},
                              {:name => "CRECHE LIDIA THOMAZ", :service_levels => [levels[0]]},
                              {:name => "CRECHE MARIA BENEDITA CONSTANCIO, IRMA", :service_levels => [levels[0]]},
                              {:name => "CRECHE MARIA JOSE DA ANUNCIACAO", :service_levels => [levels[0]]},
                              {:name => "CRECHE MERCEDES CORREA RUIZ BATISTA", :service_levels => [levels[0]]},
                              {:name => "CRECHE OLGA CAMOLESI PAVAO", :service_levels => [levels[0]]},
                              {:name => "CRECHE OLIMPIA MARIA DE JESUS CARVALHO", :service_levels => [levels[0]]},
                              {:name => "CRECHE PEDRO PENOV", :service_levels => [levels[0]]},
                              {:name => "CRECHE RECANTO ALEGRE ", :service_levels => [levels[0]]},
                              {:name => "CRECHE ROSA BROSEGHINI", :service_levels => [levels[0]]},
                              {:name => "CRECHE ROSA PEREIRA CRE", :service_levels => [levels[0]]},
                              {:name => "CRECHE SADAMITU OMOSAKO", :service_levels => [levels[0]]},
                              {:name => "CRECHE SERAPHINA BISSOLATTI", :service_levels => [levels[0]]},
                              {:name => "CRECHE SERGIO ZANARDI", :service_levels => [levels[0]]},
                              {:name => "CRECHE SILVIA FERREIRA FARAH, PROFa", :service_levels => [levels[0]]},
                              {:name => "CRECHE VILMA CATAN", :service_levels => [levels[0]]}
                            ])
# Criação das EMEIs
schools_creche = School.create([{:name => "EMEI ADELAIDE DIAS", :service_levels => [levels[1]]},
                              {:name => "EMEI ADHEMAR PEREIRA DE BARROS, DR.", :service_levels => [levels[1]]},
                              {:name => "EMEI ALICE MANHOLER PITERI", :service_levels => [levels[1]]},
                              {:name => "EMEI ALIPIO PEREIRA DOS SANTOS, PROF.", :service_levels => [levels[1]]},
                              {:name => "EMEI ANTONIO PAULINO RIBEIRO", :service_levels => [levels[1]]},
                              {:name => "EMEI CRISTINE APARECIDA DE OLIVEIRA BRAGA", :service_levels => [levels[1]]},
                              {:name => "EMEI DALVA MIRIAN PORTELLA MACHADO, PROFª.", :service_levels => [levels[1]]},
                              {:name => "EMEI DÉSCIO MENDES PEREIRA, DR.", :service_levels => [levels[1]]},
                              {:name => "EMEI ELIDE ALVES DÓRIA, PROFª", :service_levels => [levels[1]]},
                              {:name => "EMEI EMIR MACEDO NOGUEIRA. PROF.", :service_levels => [levels[1]]},
                              {:name => "EMEI ESMERALDA FERREIRA SIMÃO NOBREGA, PROFª.", :service_levels => [levels[1]]},
                              {:name => "EMEI ESTEVÃO BRETT", :service_levels => [levels[1]]},
                              {:name => "EMEI FERNANDO BUONADUCE, PROF.", :service_levels => [levels[1]]},
                              {:name => "EMEI FORTUNATA PEREIRA DE JESUS SANTOS", :service_levels => [levels[1]]},
                              {:name => "EMEI GERTRUDES DE ROSSI", :service_levels => [levels[1]]},
                              {:name => "EMEI HELENA COUTINHO", :service_levels => [levels[1]]},
                              {:name => "EMEI IGNÊS COLLINO", :service_levels => [levels[1]]},
                              {:name => "EMEI JAPHET FONTES ", :service_levels => [levels[1]]},
                              {:name => "EMEI JOSÉ FLÁVIO DE FREITAS, PROF.", :service_levels => [levels[1]]},
                              {:name => "EMEI LUZIA MOMI SASSO", :service_levels => [levels[1]]},
                              {:name => "EMEI MARIA ALVES DÓRIA, PROFª", :service_levels => [levels[1]]},
                              {:name => "EMEI MARIA APARECIDA DE CAMARGO DAMY RODRIGUES, PROFª", :service_levels => [levels[1]]},
                              {:name => "EMEI MARIA BERTONI FIORITA, PROFª", :service_levels => [levels[1]]},
                              {:name => "EMEI MARIA MADALENA L. B. FREIXEDA", :service_levels => [levels[1]]},
                              {:name => "EMEI NAIR BELLACOSA WARZEKA, PROFª", :service_levels => [levels[1]]},
                              {:name => "EMEI OMAR OGEDA MARTINS", :service_levels => [levels[1]]},
                              {:name => "EMEI OSVALDO GONÇALVES DE CARVALHO", :service_levels => [levels[1]]},
                              {:name => "EMEI OSWALDO SALLES NEMER", :service_levels => [levels[1]]},
                              {:name => "EMEI PEDRO MARTINO", :service_levels => [levels[1]]},
                              {:name => "EMEI PROVIDÊNCIA DOS ANJOS CARREIRA", :service_levels => [levels[1]]},
                              {:name => "EMEI SALVADOR SACCO", :service_levels => [levels[1]]},
                              {:name => "EMEI SEVERINO DE ARAUJO FREIRE", :service_levels => [levels[1]]},
                              {:name => "EMEI SÔNIA MARIA DE ALMEIDA FERNANDES, PROFª", :service_levels => [levels[1]]},
                              {:name => "EMEI THEREZA BIANCHI COLLINO", :service_levels => [levels[1]]},
                              {:name => "EMEI VIVALDO MARTINS SIMÕES, DR.", :service_levels => [levels[1]]},
                              {:name => "EMEI YOLANDA BOTARO VICENTE", :service_levels => [levels[1]]}])

# Criação das EMEF
schools_emef = School.create([{:name => "EMEF ALFREDO FARHAT, DEPUTADO", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF ALICE RABECHINI FERREIRA", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF ALIPIO DA SILVA LAVOURA, PROF.", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF ANEZIO CABRAL, PROF.", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF ANTONIO DE SAMPAIO, GENERAL", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF BENEDICTO WESCHENFELDER", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF BENEDITO ALVES TURIBIO", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF BITTENCOURT, MARECHAL", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF CECILIA CORREA CASTELANI, PROFa", :service_levels => [levels[2]]},
                              {:name => "EMEF DOMINGOS BLASCO, MAESTRO", :service_levels => [levels[2]]},
                              {:name => "EMEF ELIDIO MANTOVANI, MONSENHOR", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF ELZA DE CARVALHO MELLO BATTISTON, PROFa", :service_levels => [levels[2]]},
                              {:name => "EMEF FRANCISCO CAVALCANTI PONTES DE MIRANDA", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF FRANCISCO MANUEL LUMBRALES DE SA CARNEIRO, DR.", :service_levels => [levels[2]]},
                              {:name => "EMEF GASPAR DA MADRE DE DEUS, FREI", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF HUGO RIBEIRO DE ALMEIDA, DR.", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF JOAO CAMPESTRINI, PROF.", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF JOAO EUCLYDES PEREIRA, PROF.", :service_levels => [levels[2]]},
                              {:name => "EMEF JOAO GUIMARAES ROSA", :service_levels => [levels[2]]},
                              {:name => "EMEF JOAO LARIZZATTI, PROF.", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF JOSE GROSSI DIAS, PADRE", :service_levels => [levels[2]]},
                              {:name => "EMEF JOSE MANOEL AYRES, DR.", :service_levels => [levels[2]]},
                              {:name => "EMEF JOSE MARTINIANO DE ALENCAR", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF JOSE VERISSIMO DE MATOS", :service_levels => [levels[2]]},
                              {:name => "EMEF JOSIAS BAPTISTA, PASTOR", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF LAERTE JOSE DOS SANTOS, PROF.", :service_levels => [levels[2]]},
                              {:name => "EMEF LUCIANO FELICIO BIONDO, PROF.", :service_levels => [levels[2]]},
                              {:name => "EMEF LUIZ BORTOLOSSO", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF MANOEL BARBOSA DE SOUZA, PROF.", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF MANOEL TERTULIANO DE CERQUEIRA, PROF.", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF MARINA SADDI HAIDAR", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF MARINA VON PUTTKAMMER MELLI", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF MAX ZENDRON, PROF.", :service_levels => [levels[2]]},
                              {:name => "EMEF OLAVO ANTONIO BARBOSA SPINOLA , PROF", :service_levels => [levels[2]]},
                              {:name => "EMEF OLINDA MOREIRA LEMES DA CUNHA, PROFa", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF ONEIDE BORTOLOTE", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF OSCAR PENNACINO,", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF OSVALDO QUIRINO SIMOES", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF QUINTINO BOCAIUVA", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF RENATO FIUZA TELES, PROF.", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF SAAD BECHARA", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF TECLA MERLO, IRMA", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF TEREZINHA MARTINS PEREIRA, PROFa", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF TOBIAS BARRETO DE MENEZES", :service_levels => [levels[2], levels[3]]},
                              {:name => "EMEF VICTOR BRECHERET , ESCULTOR", :service_levels => [levels[2], levels[3]]}])

# Criação das CEMEIs
schools_cemei = School.create([{:name => "CEMEI ALBERTO SANTOS DUMONT", :service_levels => [levels[0], levels[1]]},
                              {:name => "CEMEI FORTUNATO ANTIÓRIO", :service_levels => [levels[0], levels[1]]},
                              {:name => "CEMEI JOÃO DE FARIAS", :service_levels => [levels[0], levels[1]]},
                              {:name => "CEMEI JOSÉ ERMÍRIO DE MORAES, SENADOR", :service_levels => [levels[0], levels[1]]},
                              {:name => "CEMEI LEONIL CRÊ BORTOLOSSO", :service_levels => [levels[0], levels[1]]},
                              {:name => "CEMEI LOURDES CÂNDIDA DE FARIA", :service_levels => [levels[0], levels[1]]},
                              {:name => "CEMEI MÁRIO QUINTANA", :service_levels => [levels[0], levels[1]]},
                              {:name => "CEMEI RUBENS BANDEIRA", :service_levels => [levels[0], levels[1]]},
                              {:name => "CEMEI VILMA FOLTRAN PORTELLA", :service_levels => [levels[0], levels[1], levels[3]]},
                              {:name => "CEMEI ZAÍRA COLLINO ODÁLIA", :service_levels => [levels[0], levels[1]]}])

# Criação das EMEIEFs
schools_emeief = School.create([{:name => "EMEIEF COLINAS D'OESTE", :service_levels => [levels[1], levels[2], levels[3]]},
                              {:name => "EMEIEF ÉLIO APARECIDO DA SILVA", :service_levels => [levels[1], levels[2], levels[3]]},
                              {:name => "EMEIEF ETIENE SALES CAMPELO, PROFª", :service_levels => [levels[1], levels[2], levels[3]]},
                              {:name => "EMEIEF MESSIAS GONÇALVES DA SILVA", :service_levels => [levels[1], levels[2], levels[3]]},
                              {:name => "EMEIEF VALTER DE OLIVEIRA FERREIRA, PROF.", :service_levels => [levels[1], levels[2], levels[3]]},
                              {:name => "EMEIEF ZULEIKA GONÇALVES MENDES, PROFª", :service_levels => [levels[1], levels[2], levels[3]]}])

# Criação das CEMEIEFs
schools_cemeief = School.create([{:name => "CEU ZONA NORTE (ZILDA ARNS, Drª)", :service_levels => [levels[0], levels[1], levels[2], levels[3]]},
                              {:name => "CEMEIEF MARIA JOSÉ FERREIRA FERRAZ, PROFª.", :service_levels => [levels[0], levels[1], levels[2]]},
                              {:name => "CEMEIEF MARIA TARCILLA FORNASARO MELLI", :service_levels => [levels[0], levels[1], levels[2]]},
                              {:name => "CEMEIEF ZILDA ARNS, Drª", :service_levels => [levels[0], levels[1], levels[2]]},
                              {:name => "CEMEIEF MÁRIO SEBASTIÃO ALVES DE LIMA", :service_levels => [levels[0], levels[1], levels[2]]}])

# Criação das BURJATO
schools_burjato = School.create([{:name => "DR. EDMUNDO CAMPANHA BURJATO", :service_levels => [levels[4]]}])

# Criação das CRECHES Conveniadas
schools_creches_conveniadas = School.create([{:name => "Centro de Participação Popular do Jardim Veloso".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação União de Mães do Jardim das Flores".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação Faça uma Criança Sorrir de Osasco e Região – Núcleo I".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação Faça uma Criança Sorrir de Osasco e Região – Núcleo II Alfacriso".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação das Mães do Jardim Veloso".upcase, :service_levels => [levels[5]]},
                                                {:name => "Entidade: Associação das Mães Unidas do Novo Osasco – AMUNO I".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação das Mães Unidas do Novo Osasco – AMUNO II".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação Beneficente Gotas de Amor".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação Quintal Mágico".upcase, :service_levels => [levels[5]]},
                                                {:name => "Centro Social Santo Antonio".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação Padre Domingos Barbé".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação das Mulheres pela Educação – Núcleo Aventura do Aprender".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação das Mulheres pela Educação – Núcleo Brilho do Aprender".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação das Mulheres pela Educação – Núcleo Casa do Aprender".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação das Mulheres pela Educação – Núcleo Cecília Meireles".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação das Mulheres pela Educação – Núcleo Começando Aprender".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação das Mulheres pela Educação – Núcleo Menino Jesus".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação das Mulheres pela Educação – Núcleo Recanto do Aprender".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação das Mulheres em Defesa à Criança Helena Maria".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação das Mulheres em Defesa à Criança – Tarcila do Amaral".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação de Proteção à Maternidade e à Adolescência (ASPROMATINA) – Padre Domingos Tonini".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação de Proteção à Maternidade e à Adolescência (ASPROMATINA) – Padre Guerrino".upcase, :service_levels => [levels[5]]},
                                                {:name => "ASCC – Associação Solidária Crescendo Cidadã I - Açucará".upcase, :service_levels => [levels[5]]},
                                                {:name => "ASCC – Associação Solidária Crescendo Cidadã II – Bela Vista".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação de Educação Popular Pixote I".upcase, :service_levels => [levels[5]]},
                                                {:name => "Associação de Educação Popular Pixote II".upcase, :service_levels => [levels[5]]},
                                                {:name => "Lar da Criança Emmanuel Núcleo Kardecista 21 de Abril".upcase, :service_levels => [levels[5]]}])


segments_creche = Segment.create([{:name => "Familiares", :service_level => levels[0]},
                                {:name => "Funcionários", :service_level => levels[0]},
                                {:name => "Professores", :service_level => levels[0]},
                                {:name => "Gestores", :service_level => levels[0]}])

segments_emei = Segment.create([{:name => "Familiares", :service_level => levels[1]},
                                {:name => "Funcionários", :service_level => levels[1]},
                                {:name => "Professores", :service_level => levels[1]},
                                {:name => "Gestores", :service_level => levels[1]}])

segments_emef = Segment.create([{:name => 'Educandos', :service_level => levels[2]},
                                {:name => 'Familiares', :service_level => levels[2]},
                                {:name => 'Funcionários', :service_level => levels[2]},
                                {:name => 'Professores', :service_level => levels[2]},
                                {:name => 'Gestores', :service_level => levels[2]}])

segments_eja = Segment.create([{:name => 'Educandos', :service_level => levels[3]},
                                {:name => 'Funcionários', :service_level => levels[3]},
                                {:name => 'Gestores', :service_level => levels[3]},
                                {:name => 'Professores', :service_level => levels[3]}])

segments_burjato = Segment.create([{:name => 'Trabalhadores', :service_level => levels[4]},
                                {:name => 'Gestores', :service_level => levels[4]},
                                {:name => 'Familiares', :service_level => levels[4]}])


segments_creches_conveniadas = Segment.create([{:name => 'Gestores', :service_level => levels[5]},
                                {:name => 'Coordenadores pedagógicos', :service_level => levels[5]},
                                {:name => 'Professores', :service_level => levels[5]},
                                {:name => 'Funcionários de apoio', :service_level => levels[5]},
                                {:name => 'Familiares', :service_level => levels[5]}])

dimensions_creche = Dimension.create([{:name => 'Ambiente educativo', :number => 1, :service_level => levels[0]},
                                    {:name => 'Ambiente físico escolar e materiais', :number => 2, :service_level => levels[0]},
                                    {:name => 'Planejamento institucional e prática pedagógica', :number => 3, :service_level => levels[0]},
                                    {:name => 'Avaliação', :number => 4, :service_level => levels[0]},
                                    {:name => 'Acesso e permanência dos educandos na escola', :number => 5, :service_level => levels[0]},
                                    {:name => 'Promoção da saúde', :number => 6, :service_level => levels[0]},
                                    {:name => 'Educação socioambiental e práticas ecopedagógicas', :number => 7, :service_level => levels[0]},
                                    {:name => 'Envolvimento com as famílias e participação na rede de proteção social', :number => 8, :service_level => levels[0]},
                                    {:name => 'Gestão escolar democrática', :number => 9, :service_level => levels[0]},
                                    {:name => 'Formação e condições de trabalho dos profissionais da escola', :number => 10, :service_level => levels[0]}])


dimensions_emei = Dimension.create([{:name => 'Ambiente educativo', :number => 1, :service_level => levels[1]},
                                    {:name => 'Ambiente físico escolar e materiais', :number => 2, :service_level => levels[1]},
                                    {:name => 'Planejamento institucional e prática pedagógica', :number => 3, :service_level => levels[1]},
                                    {:name => 'Avaliação', :number => 4, :service_level => levels[1]},
                                    {:name => 'Acesso e permanência dos educandos na escola', :number => 5, :service_level => levels[1]},
                                    {:name => 'Promoção da saúde', :number => 6, :service_level => levels[1]},
                                    {:name => 'Educação socioambiental e práticas ecopedagógicas', :number => 7, :service_level => levels[1]},
                                    {:name => 'Envolvimento com as famílias e participação na rede de proteção social', :number => 8, :service_level => levels[1]},
                                    {:name => 'Gestão escolar democrática', :number => 9, :service_level => levels[1]},
                                    {:name => 'Formação e condições de trabalho dos profissionais da escola', :number => 10, :service_level => levels[1]}])

dimensions_emef = Dimension.create([{:name => 'Ambiente educativo', :number => 1, :service_level => levels[2]},
                                    {:name => 'Ambiente físico escolar e materiais', :number => 2, :service_level => levels[2]},
                                    {:name => 'Planejamento institucional e prática pedagógica', :number => 3, :service_level => levels[2]},
                                    {:name => 'Avaliação', :number => 4, :service_level => levels[2]},
                                    {:name => 'Acesso e permanência dos educandos na escola', :number => 5, :service_level => levels[2]},
                                    {:name => 'Promoção da saúde', :number => 6, :service_level => levels[2]},
                                    {:name => 'Educação socioambiental e práticas ecopedagógicas', :number => 7, :service_level => levels[2]},
                                    {:name => 'Envolvimento com as famílias e participação na rede de proteção social', :number => 8, :service_level => levels[2]},
                                    {:name => 'Gestão escolar democrática', :number => 9, :service_level => levels[2]},
                                    {:name => 'Formação e condições de trabalho dos profissionais da escola', :number => 10, :service_level => levels[2]},
                                    {:name => 'Processos de alfabetização e letramento', :number => 11, :service_level => levels[2]}])

#TODO Dimenões EJA e Burjato

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

#TODO Dimenões EJA e Burjato

