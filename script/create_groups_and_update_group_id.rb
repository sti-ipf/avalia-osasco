def create_groups(schools, group)
  schools.each do |s|
    GroupsSchool.create(:group_id => group.id, :school_id => s.id)
  end
end

conn = ActiveRecord::Base.connection

ServiceLevel.all(:conditions => "id <= 4").each do |s|
  (1..4).each do |i|
    Group.create(:name => "Grupo #{i}", :service_level_id => s.id)
  end
end


group = Group.first(:conditions => "service_level_id = 1 AND name = 'Grupo 4'")

schools = School.find_by_sql("
            SELECT id FROM schools 
            WHERE name IN
              (
              'Creche Amélia Tozzeto Viviane',
              'Creche José Espinosa',
              'Creche Alha Elias Abibe',
              'Creche Giuseppa Bersani Michelin',
              'CEMEI José Ermírio de Moraes, Senador',
              'CEMEI Mário Quintana',
              'Creche Mercedes Correa Ruiz Batista',
              'Creche Daisy Ribeiro Neves',
              'Creche Sergio Zanardi',
              'CEMEI Zaira Collino Odália',
              'Creche Recanto Alegre',
              'CEMEI Alberto Santos Dumont',
              'Creche Inês Sanches Mendes'
              )")

create_groups(schools, group)

group = Group.first(:conditions => "service_level_id = 1 AND name = 'Grupo 3'")

schools = School.find_by_sql("
  SELECT id FROM schools 
  WHERE name IN
    (
    'Creche Vilma Catan',
    'Creche Maria José da Anunciação',
    'CRECHE Seraphina Bissolatti',
    'CEMEIEF Maria Tarcilla Fornasaro Melli',
    'CRECHE José Carlos Di Mambro, PE.',
    'Creche Pedro Penov',
    'Creche Maria Benedita Constâncio, Irmã',
    'Creche Hilda Alves dos Santos Marim',
    'Creche Rosa Pereira Crê',
    'Creche Hermínia Lopes',
    'Creche Lídia Thomaz',
    'Creche João Corrêa',
    'Creche Ida Belmonte Biscuola'
    )")

create_groups(schools, group)

group = Group.first(:conditions => "service_level_id = 1 AND name = 'Grupo 2'")

schools = School.find_by_sql("
            SELECT id FROM schools 
            WHERE name IN(
              'CRECHE ELZA BATISTON',
              'Creche Sadamitu Omosako',
              'Creche Silvia Ferreira Farah, Profa',
              'CEU Zona Norte (Zilda Arns, Drª)',
              'Creche Alzira Silva Medeiros',
              'Creche Olga Camolesi Pavão',
              'Creche Leonil Crê Bortolosso',
              'CRECHE ROSA BROSEGHINI',
              'Creche Olímpia Maria de Jesus Carvalho',
              'Creche Ezio Melli',
              'CEMEI Gertrudes de Rossi'
            )")

create_groups(schools, group)

group = Group.first(:conditions => "service_level_id = 1 AND name = 'Grupo 1'")

schools = School.find_by_sql("
          SELECT id FROM schools 
          WHERE name IN(
            'Creche Benedita de Oliveira',
            'CEMEI Lourdes Candida de Faria',
            'CEMEI Vilma Foltran Portella',
            'CEMEIEF Maria José Ferreira Ferraz, Profª.',
            'CEMEI Rubens Bandeira',
            'CEMEI João de Farias',
            'Creche Joaquina França Garcia, Profª',
            'CEMEI Fortunato Antiório',
            'CEMEI Mário Sebastião Alves de Lima',
            'CEMEIEF Darcy Ribeiro, Prof.'
          )")

create_groups(schools, group)


#EMEFs

group = Group.first(:conditions => "service_level_id = 3 AND name = 'Grupo 1'")

schools = School.find_by_sql("
          SELECT id FROM schools 
          WHERE name IN(
            'EMEIEF ÉLIO APARECIDO DA SILVA',
            'EMEF GASPAR DA MADRE DE DEUS, FREI',
            'EMEF FRANCISCO MANUEL LUMBRALES DE SA CARNEIRO, DR.',
            'EMEF MARINA SADDI HAIDAR',
            'EMEF DOMINGOS BLASCO, MAESTRO',
            'EMEF SAAD BECHARA',
            'EMEF HUGO RIBEIRO DE ALMEIDA, DR.',
            'EMEF JOAO CAMPESTRINI, PROF.',
            'EMEIEF VALTER DE OLIVEIRA FERREIRA, PROF.',
            'EMEF ALIPIO DA SILVA LAVOURA, PROF.',
            'EMEF ONEIDE BORTOLOTE',
            'EMEIEF JOAO EUCLYDES PEREIRA, PROF.',
            'EMEF QUINTINO BOCAIUVA',
            'EMEIEF ZULEIKA GONÇALVES MENDES, PROFª'
            )")

create_groups(schools, group)

group = Group.first(:conditions => "service_level_id = 3 AND name = 'Grupo 2'")

schools = School.find_by_sql("
          SELECT id FROM schools 
          WHERE name IN(
            'EMEF TEREZINHA MARTINS PEREIRA, PROFa',
            'EMEF MANOEL BARBOSA DE SOUZA, PROF.',
            'EMEF JOSIAS BAPTISTA, PASTOR',
            'EMEF ALFREDO FARHAT, DEPUTADO',
            'EMEF OLINDA MOREIRA LEMES DA CUNHA, PROFa',
            'EMEF TECLA MERLO, IRMA',
            'EMEF OSCAR PENNACINO',
            'EMEF ELIDIO MANTOVANI, MONSENHOR',
            'CEU ZONA NORTE (ZILDA ARNS, Drª)',
            'CEMEIEF DARCY RIBEIRO, PROF.',
            'EMEF JOSE VERISSIMO DE MATOS',
            \"EMEIEF COLINAS D'OESTE\"
            )")

create_groups(schools, group)

group = Group.first(:conditions => "service_level_id = 3 AND name = 'Grupo 3'")

schools = School.find_by_sql("
          SELECT id FROM schools 
          WHERE name IN(
            'EMEIEF MESSIAS GONÇALVES DA SILVA',
            'EMEIEF ETIENE SALES CAMPELO, PROFª',
            'EMEF OLAVO ANTONIO BARBOSA SPINOLA , PROF',
            'EMEF JOAO GUIMARAES ROSA',
            'EMEF LUCIANO FELICIO BIONDO, PROF.',
            'EMEF TOBIAS BARRETO DE MENEZES',
            'EMEF OSVALDO QUIRINO SIMOES',
            'EMEF CECILIA CORREA CASTELANI, PROFa',
            'EMEF ELZA DE CARVALHO MELLO BATTISTON, PROFa',
            'EMEF ALICE RABECHINI FERREIRA',
            'EMEF LUIZ BORTOLOSSO',
            'EMEF OSVALDO QUIRINO SIMOES',
            'EMEF ANTONIO DE SAMPAIO, GENERAL'
            )")

create_groups(schools, group)

group = Group.first(:conditions => "service_level_id = 3 AND name = 'Grupo 4'")

schools = School.find_by_sql("
          SELECT id FROM schools 
          WHERE name IN(
            'CEMEIEF MARIA JOSÉ FERREIRA FERRAZ, PROFª.',
            'CEMEIEF MARIA TARCILLA FORNASARO MELLI',
            'EMEF MARINA VON PUTTKAMMER MELLI',
            'EMEF BENEDICTO WESCHENFELDER',
            'EMEF BITTENCOURT, MARECHAL',
            'EMEF FRANCISCO CAVALCANTI PONTES DE MIRANDA',
            'EMEF JOSE GROSSI DIAS, PADRE',
            'EMEF JOSE MANOEL AYRES, DR.',
            'EMEF LAERTE JOSE DOS SANTOS, PROF.',
            'EMEF MAX ZENDRON, PROF.',
            'EMEF RENATO FIUZA TELES, PROF.',
            'EMEF ANEZIO CABRAL, PROF.',
            'EMEF JOSE MARTINIANO DE ALENCAR',
            'EMEF VICTOR BRECHERET , ESCULTOR',
            'EMEF JOAO LARIZZATTI, PROF.',
            'EMEF BENEDITO ALVES TURIBIO',
            'EMEF MANOEL TERTULIANO DE CERQUEIRA, PROF.'
            )")

create_groups(schools, group)

#EMEIs

group = Group.first(:conditions => "service_level_id = 2 AND name = 'Grupo 4'")

schools = School.find_by_sql("
          SELECT id FROM schools 
          WHERE name IN(
            'CEMEI ZAÍRA COLLINO ODÁLIA',
            'EMEI CRISTINE APARECIDA DE OLIVEIRA BRAGA',
            'CEMEI ALBERTO SANTOS DUMONT',
            'EMEI OSWALDO SALLES NEMER',
            'EMEI ESMERALDA FERREIRA SIMÃO NOBREGA, PROFª.',
            'EMEIEF MESSIAS GONÇALVES DA SILVA',
            'EMEI EMIR MACEDO NOGUEIRA. PROF.',
            'EMEI DÉSCIO MENDES PEREIRA, DR.',
            'EMEIEF ZULEIKA GONÇALVES MENDES, PROFª',
            'CEMEI JOSÉ ERMÍRIO DE MORAES, SENADOR',
            'CEMEI MÁRIO QUINTANA',
            'EMEI SALVADOR SACCO',
            'EMEI ADELAIDE DIAS'
            )")

create_groups(schools, group)


group = Group.first(:conditions => "service_level_id = 2 AND name = 'Grupo 3'")

schools = School.find_by_sql("
          SELECT id FROM schools 
          WHERE name IN(
            'EMEI HELENA COUTINHO',
            'EMEI PEDRO MARTINO',
            'EMEI MARIA MADALENA L. B. FREIXEDA',
            'EMEI ALIPIO PEREIRA DOS SANTOS, PROF.',
            'EMEI ESTEVÃO BRETT',
            'CEMEIEF MARIA TARCILLA FORNASARO MELLI',
            'EMEI DALVA MIRIAN PORTELLA MACHADO, PROFª.',
            'EMEI FERNANDO BUONADUCE, PROF.',
            'EMEI ALICE MANHOLER PITERI',
            'EMEI FORTUNATA PEREIRA DE JESUS SANTOS',
            'EMEI ELIDE ALVES DÓRIA, PROFª',
            'EMEI ADHEMAR PEREIRA DE BARROS, DR.',
            'EMEI SEVERINO DE ARAUJO FREIRE',
            'EMEIEF ETIENE SALES CAMPELO, PROFª',
            'EMEI PROVIDÊNCIA DOS ANJOS CARREIRA',
            'EMEI IGNÊS COLLINO',
            'EMEI ANTONIO PAULINO RIBEIRO',
            'EMEI LUZIA MOMI SASSO',
            'EMEI THEREZA BIANCHI COLLINO'
            )")

create_groups(schools, group)

group = Group.first(:conditions => "service_level_id = 2 AND name = 'Grupo 2'")

schools = School.find_by_sql("
          SELECT id FROM schools 
          WHERE name IN(
            'EMEI MARIA ALVES DÓRIA, PROFª',
            'EMEI NAIR BELLACOSA WARZEKA, PROFª',
            'EMEIEF VALTER DE OLIVEIRA FERREIRA, PROF.',
            'CEU ZONA NORTE (ZILDA ARNS, Drª)',
            'CEMEI GERTRUDES DE ROSSI',
            'EMEI SÔNIA MARIA DE ALMEIDA FERNANDES, PROFª',
            'EMEI MARIA APARECIDA DE CAMARGO DAMY RODRIGUES, PROFª',
            'EMEIEF JOAO EUCLYDES PEREIRA, PROF.',
            \"EMEIEF COLINAS D'OESTE\"
            )")

create_groups(schools, group)

group = Group.first(:conditions => "service_level_id = 2 AND name = 'Grupo 1'")

schools = School.find_by_sql("
          SELECT id FROM schools 
          WHERE name IN(
            'EMEI MARIA BERTONI FIORITA, PROFª',
            'EMEI OMAR OGEDA MARTINS',
            'EMEI JAPHET FONTES',
            'CEMEI LOURDES CÂNDIDA DE FARIA',
            'CEMEI VILMA FOLTRAN PORTELLA',
            'EMEI OSVALDO GONÇALVES DE CARVALHO',
            'EMEI YOLANDA BOTARO VICENTE',
            'CEMEI FORTUNATO ANTIÓRIO',
            'CEMEI MÁRIO SEBASTIÃO ALVES DE LIMA',
            'CEMEIEF DARCY RIBEIRO, PROF.',
            'EMEI VIVALDO MARTINS SIMÕES, DR.',
            'CEMEIEF MARIA JOSÉ FERREIRA FERRAZ, PROFª.',
            'CEMEI RUBENS BANDEIRA',
            'CEMEI JOÃO DE FARIAS',
            'EMEI JOSÉ FLÁVIO DE FREITAS, PROF.',
            'EMEIEF ÉLIO APARECIDO DA SILVA'
            )")

create_groups(schools, group)

#EJAs

group = Group.first(:conditions => "service_level_id = 4 AND name = 'Grupo 1'")

schools = School.find_by_sql("
          SELECT id FROM schools 
          WHERE name IN(
            'EMEF ONEIDE BORTOLOTE',
            'EMEIEF ÉLIO APARECIDO DA SILVA',
            'EMEF LUIZ BORTOLOSSO',
            'EMEF TEREZINHA MARTINS PEREIRA, PROFa',
            'EMEF HUGO RIBEIRO DE ALMEIDA, DR.',
            'CEMEI VILMA FOLTRAN PORTELLA',
            'EMEF BENEDICTO WESCHENFELDER',
            'EMEF MARINA SADDI HAIDAR',
            'EMEF TOBIAS BARRETO DE MENEZES',
            'EMEF SAAD BECHARA'
            )")

create_groups(schools, group)

group = Group.first(:conditions => "service_level_id = 4 AND name = 'Grupo 2'")

schools = School.find_by_sql("
          SELECT id FROM schools 
          WHERE name IN(
            'EMEF TECLA MERLO, IRMA',
            'EMEF VICTOR BRECHERET , ESCULTOR',
            'EMEIEF VALTER DE OLIVEIRA FERREIRA, PROF.',
            'EMEF OLINDA MOREIRA LEMES DA CUNHA, PROFa',
            'EMEF MANOEL BARBOSA DE SOUZA, PROF.',
            'EMEF JOSIAS BAPTISTA, PASTOR',
            \"EMEIEF COLINAS D'OESTE\",
            'EMEF JOAO CAMPESTRINI, PROF.',
            'EMEF ALIPIO DA SILVA LAVOURA, PROF.',
            'CEU ZONA NORTE (ZILDA ARNS, Drª)',
            'EMEIEF ZULEIKA GONÇALVES MENDES, PROFª',
            'EMEF RENATO FIUZA TELES, PROF.'
            )")

create_groups(schools, group)

group = Group.first(:conditions => "service_level_id = 4 AND name = 'Grupo 3'")

schools = School.find_by_sql("
          SELECT id FROM schools 
          WHERE name IN(
            'EMEF BITTENCOURT, MARECHAL',
            'EMEF GASPAR DA MADRE DE DEUS, FREI',
            'EMEF JOAO LARIZZATTI, PROF.',
            'EMEF ANTONIO DE SAMPAIO, GENERAL',
            'EMEF FRANCISCO CAVALCANTI PONTES DE MIRANDA',
            'EMEF JOSE MARTINIANO DE ALENCAR',
            'EMEIEF ETIENE SALES CAMPELO, PROFª',
            'EMEF OSCAR PENNACINO',
            'EMEF ALFREDO FARHAT, DEPUTADO',
            'EMEF OSVALDO QUIRINO SIMOES'
            )")

create_groups(schools, group)

group = Group.first(:conditions => "service_level_id = 4 AND name = 'Grupo 4'")

schools = School.find_by_sql("
          SELECT id FROM schools 
          WHERE name IN(
            'EMEF ELIDIO MANTOVANI, MONSENHOR',
            'EMEF BENEDITO ALVES TURIBIO',
            'EMEF QUINTINO BOCAIUVA',
            'EMEF ALICE RABECHINI FERREIRA',
            'EMEF ANEZIO CABRAL, PROF.',
            'EMEF MARINA VON PUTTKAMMER MELLI',
            'EMEF MANOEL TERTULIANO DE CERQUEIRA, PROF.',
            'EMEIEF MESSIAS GONÇALVES DA SILVA'
            )")

create_groups(schools, group)