# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

levels = ServiceLevel.create([{:name => "EMEI/CRECHE"}, {:name => "EMEF"}])

schools_emei = School.create([{:name => "CRECHE ALHA ELIAS ABIBE", :service_level => levels[0]},
                              {:name => "CRECHE ALZIRA SILVA MEDEIROS", :service_level => levels[0]},
                              {:name => "CRECHE AMELIA TOZZETO VIVIANE", :service_level => levels[0]},
                              {:name => "CRECHE BENEDITA DE OLIVEIRA", :service_level => levels[0]},
                              {:name => "CRECHE DAISY RIBEIRO NEVES", :service_level => levels[0]},
                              {:name => "CRECHE ELZA BATISTON", :service_level => levels[0]},
                              {:name => "CRECHE EZIO MELLI", :service_level => levels[0]},
                              {:name => "CRECHE GIUSEPPA BERSANI MICHELIN", :service_level => levels[0]},
                              {:name => "CRECHE HERMINIA LOPES", :service_level => levels[0]},
                              {:name => "CRECHE HILDA ALVES DOS SANTOS MARIM", :service_level => levels[0]},
                              {:name => "CRECHE IDA BELMONTE BISCUOLA", :service_level => levels[0]},
                              {:name => "CRECHE INES SANCHES MENDES", :service_level => levels[0]},
                              {:name => "CRECHE JOAO CORREA", :service_level => levels[0]},
                              {:name => "CRECHE JOAQUINA FRANCA GARCIA, PROFa", :service_level => levels[0]},
                              {:name => "CRECHE JOSE ESPINOSA", :service_level => levels[0]},
                              {:name => "CRECHE JOSE CARLOS DI MAMBRO, PE.", :service_level => levels[0]},
                              {:name => "CRECHE LIDIA THOMAZ", :service_level => levels[0]},
                              {:name => "CRECHE MARIA BENEDITA CONSTANCIO, IRMA", :service_level => levels[0]},
                              {:name => "CRECHE MARIA JOSE DA ANUNCIACAO", :service_level => levels[0]},
                              {:name => "CRECHE MERCEDES CORREA RUIZ BATISTA", :service_level => levels[0]},
                              {:name => "CRECHE OLGA CAMOLESI PAVAO", :service_level => levels[0]},
                              {:name => "CRECHE OLIMPIA MARIA DE JESUS CARVALHO", :service_level => levels[0]},
                              {:name => "CRECHE PEDRO PENOV", :service_level => levels[0]},
                              {:name => "CRECHE RECANTO ALEGRE ", :service_level => levels[0]},
                              {:name => "CRECHE ROSA BROSEGHINI", :service_level => levels[0]},
                              {:name => "CRECHE ROSA PEREIRA CRE", :service_level => levels[0]},
                              {:name => "CRECHE SADAMITU OMOSAKO", :service_level => levels[0]},
                              {:name => "CRECHE SERAPHINA BISSOLATTI", :service_level => levels[0]},
                              {:name => "CRECHE SERGIO ZANARDI", :service_level => levels[0]},
                              {:name => "CRECHE SILVIA FERREIRA FARAH, PROFa", :service_level => levels[0]},
                              {:name => "CRECHE VILMA CATAN", :service_level => levels[0]}])

schools_emef = School.create([{:name => "EMEF ALFREDO FARHAT, DEPUTADO", :service_level => levels[1]},
                              {:name => "EMEF ALICE RABECHINI FERREIRA", :service_level => levels[1]},
                              {:name => "EMEF ALIPIO DA SILVA LAVOURA, PROF.", :service_level => levels[1]},
                              {:name => "EMEF ANEZIO CABRAL, PROF.", :service_level => levels[1]},
                              {:name => "EMEF ANTONIO DE SAMPAIO, GENERAL", :service_level => levels[1]},
                              {:name => "EMEF BENEDICTO WESCHENFELDER", :service_level => levels[1]},
                              {:name => "EMEF BENEDITO ALVES TURIBIO", :service_level => levels[1]},
                              {:name => "EMEF BITTENCOURT, MARECHAL", :service_level => levels[1]},
                              {:name => "EMEF CECILIA CORREA CASTELANI, PROFa", :service_level => levels[1]},
                              {:name => "EMEF DOMINGOS BLASCO, MAESTRO", :service_level => levels[1]},
                              {:name => "EMEF ELIDIO MANTOVANI, MONSENHOR", :service_level => levels[1]},
                              {:name => "EMEF ELZA DE CARVALHO MELLO BATTISTON, PROFa", :service_level => levels[1]},
                              {:name => "EMEF FRANCISCO CAVALCANTI PONTES DE MIRANDA", :service_level => levels[1]},
                              {:name => "EMEF FRANCISCO MANUEL LUMBRALES DE SA CARNEIRO, DR.", :service_level => levels[1]},
                              {:name => "EMEF GASPAR DA MADRE DE DEUS, FREI", :service_level => levels[1]},
                              {:name => "EMEF HUGO RIBEIRO DE ALMEIDA, DR.", :service_level => levels[1]},
                              {:name => "EMEF JOAO CAMPESTRINI, PROF.", :service_level => levels[1]},
                              {:name => "EMEF JOAO EUCLYDES PEREIRA, PROF.", :service_level => levels[1]},
                              {:name => "EMEF JOAO GUIMARAES ROSA", :service_level => levels[1]},
                              {:name => "EMEF JOAO LARIZZATTI, PROF.", :service_level => levels[1]},
                              {:name => "EMEF JOSE GROSSI DIAS, PADRE", :service_level => levels[1]},
                              {:name => "EMEF JOSE MANOEL AYRES, DR.", :service_level => levels[1]},
                              {:name => "EMEF JOSE MARTINIANO DE ALENCAR", :service_level => levels[1]},
                              {:name => "EMEF JOSE VERISSIMO DE MATOS", :service_level => levels[1]},
                              {:name => "EMEF JOSIAS BAPTISTA, PASTOR", :service_level => levels[1]},
                              {:name => "EMEF LAERTE JOSE DOS SANTOS, PROF.", :service_level => levels[1]},
                              {:name => "EMEF LUCIANO FELICIO BIONDO, PROF.", :service_level => levels[1]},
                              {:name => "EMEF LUIZ BORTOLOSSO", :service_level => levels[1]},
                              {:name => "EMEF MANOEL BARBOSA DE SOUZA, PROF.", :service_level => levels[1]},
                              {:name => "EMEF MANOEL TERTULIANO DE CERQUEIRA, PROF.", :service_level => levels[1]},
                              {:name => "EMEF MARINA SADDI HAIDAR", :service_level => levels[1]},
                              {:name => "EMEF MARINA VON PUTTKAMMER MELLI", :service_level => levels[1]},
                              {:name => "EMEF MAX ZENDRON, PROF.", :service_level => levels[1]},
                              {:name => "EMEF OLAVO ANTONIO BARBOSA SPINOLA , PROF", :service_level => levels[1]},
                              {:name => "EMEF OLINDA MOREIRA LEMES DA CUNHA, PROFa", :service_level => levels[1]},
                              {:name => "EMEF ONEIDE BORTOLOTE", :service_level => levels[1]},
                              {:name => "EMEF OSCAR PENNACINO,", :service_level => levels[1]},
                              {:name => "EMEF OSVALDO QUIRINO SIMOES", :service_level => levels[1]},
                              {:name => "EMEF QUINTINO BOCAIUVA", :service_level => levels[1]},
                              {:name => "EMEF RENATO FIUZA TELES, PROF.", :service_level => levels[1]},
                              {:name => "EMEF SAAD BECHARA", :service_level => levels[1]},
                              {:name => "EMEF TECLA MERLO, IRMA", :service_level => levels[1]},
                              {:name => "EMEF TEREZINHA MARTINS PEREIRA, PROFa", :service_level => levels[1]},
                              {:name => "EMEF TOBIAS BARRETO DE MENEZES", :service_level => levels[1]},
                              {:name => "EMEF VICTOR BRECHERET , ESCULTOR", :service_level => levels[1]}])

segments_emei = Segment.create([{:name => "Familiares", :service_level => levels[0]},
                                {:name => "Funcionários", :service_level => levels[0]},
                                {:name => "Professores e Gestores", :service_level => levels[0]}])

segments_emef = Segment.create([{:name => 'Educandos', :service_level => levels[1]},
                                {:name => 'Familiares', :service_level => levels[1]},
                                {:name => 'Funcionários', :service_level => levels[1]},
                                {:name => 'Professores e Gestores', :service_level => levels[1]}])

password_emei = Password.create([{:password => '123456', :school => schools_emei[0], :segment => segments_emei[0]},
                                  {:password => '234567', :school => schools_emei[1], :segment => segments_emei[1]},
                                  {:password => '345678', :school => schools_emei[2], :segment => segments_emei[3]}])

password_emef = Password.create([{:password => 'zxcvbn', :school => schools_emef[0], :segment => segments_emef[0]},
                                  {:password => 'asdfghj', :school => schools_emef[1], :segment => segments_emef[1]},
                                  {:password => 'qwerty', :school => schools_emef[2], :segment => segments_emef[2]},
                                  {:password => 'poiuyt', :school => schools_emef[3], :segment => segments_emef[3]}])

dimensions_emei = Dimension.create([{:name => 'Ambiente educativo', :number => 1, :service_level => levels[0]},
                                    {:name => 'Ambiente físico escolar e materiais', :number => 2, :service_level => levels[0]},
                                    {:name => 'Planejamento institucional e prática pedagógica', :number => 3, :service_level => levels[0]},
                                    {:name => 'Avaliação', :number => 4, :service_level => levels[0]},
                                    {:name => 'Acesso e permanência dos educandos na escola', :number => 5, :service_level => levels[0]},
                                    {:name => 'Promoção da saúde', :number => 6, :service_level => levels[0]},
                                    {:name => 'Educação socioambiental e práticas ecopedagógicas', :number => 7, :service_level => levels[0]},
                                    {:name => 'Envolvimento com as famílias e participação na rede de proteção social', :number => 8, :service_level => levels[0]},
                                    {:name => 'Gestão escolar democrática', :number => 9, :service_level => levels[0]},
                                    {:name => 'Formação e condições de trabalho dos profissionais da escola', :number => 10, :service_level => levels[0]}])

dimensions_emef = Dimension.create([{:name => 'Ambiente educativo', :number => 1, :service_level => levels[1]},
                                    {:name => 'Ambiente físico escolar e materiais', :number => 2, :service_level => levels[1]},
                                    {:name => 'Planejamento institucional e prática pedagógica', :number => 3, :service_level => levels[1]},
                                    {:name => 'Avaliação', :number => 4, :service_level => levels[1]},
                                    {:name => 'Acesso e permanência dos educandos na escola', :number => 5, :service_level => levels[1]},
                                    {:name => 'Promoção da saúde', :number => 6, :service_level => levels[1]},
                                    {:name => 'Educação socioambiental e práticas ecopedagógicas', :number => 7, :service_level => levels[1]},
                                    {:name => 'Envolvimento com as famílias e participação na rede de proteção social', :number => 8, :service_level => levels[1]},
                                    {:name => 'Gestão escolar democrática', :number => 9, :service_level => levels[1]},
                                    {:name => 'Formação e condições de trabalho dos profissionais da escola', :number => 10, :service_level => levels[1]},
                                    {:name => 'Processos de alfabetização e letramento', :number => 11, :service_level => levels[1]}])

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

