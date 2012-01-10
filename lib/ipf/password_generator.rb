module IPF
  class PasswordGenerator
    def generate_all
      saved_passwords = []
      Password.delete_all
      levels = ServiceLevel.all
      levels.each do |level|
        level.segments.each do |segment|
          level.schools.each do |school|
            newpass = genpass 6
            while(saved_passwords.include? newpass)
              newpass = genpass 6
            end
            password = Password.create(:password => newpass, :school => school, :segment => segment, :service_level => level)
            saved_passwords << newpass
          end
        end
      end
    end

    def generate_specific_school school_id
      school = School.find(school_id)
      school.service_levels.each do |level|
        level.segments.each do |segment|
          newpass = genpass 6
          while(!Password.find_by_password(newpass).nil?)
            newpass = genpass 6
          end
          password = Password.create(:password => newpass, :school => school, :segment => segment, :service_level => level)
        end
      end

    end

    def generate_for_creches_conveniadas
      service_level = ServiceLevel.find_by_name("CRECHE CONVENIADA")
      schools = service_level.schools
      schools.each do |school|
        generate_specific_school school.id
      end
    end

    def generate_for_sorocaba
      service_level = nil
      second_service_level = nil
      School.all.each do |s|
        count_first = s.service_levels.first.segments.count
        count_second = s.service_levels.last.segments.count
        if count_first > count_second
          service_level = s.service_levels.first
          second_service_level = s.service_levels.last
        elsif count_first < count_second
          service_level = s.service_levels.last
          second_service_level = s.service_levels.first
        else
          service_level = s.service_levels.first
          second_service_level = s.service_levels.last
        end
        service_level.segments.each do |seg|
          passwords_total = 1
          if two_passwords?(s.name, seg.name)
            PasswordControl.create(:school_id => s.id, :service_level_id => second_service_level.id, 
            :passwords_total => passwords_total , :segment_id => seg.id)
          end
          PasswordControl.create(:school_id => s.id, :service_level_id => service_level.id, 
            :passwords_total => passwords_total , :segment_id => seg.id)
        end
      end      

      PasswordControl.all.each do |s|
        newpass = genpass 6
        while(!Password.find_by_password(newpass).nil?)
          newpass = genpass 6
        end
        password = Password.create(:password => newpass, :school_id => s.school_id, :segment_id => s.segment_id, :service_level_id => s.service_level_id)
      end
    end

    private
      def genpass( len )
        chars = ("a".."h").to_a + ["j", "k"] + ("m".."z").to_a + ["0"] + ("2".."9").to_a
        newpass = ""
        1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
        return newpass
      end

      def two_passwords?(school_name, segment_name)
        schools_1 = ['Achilles de Almeida', 'Flávio de Souza Nogueira', 'Getúlio Vargas', 'Leonor Pinto Thomaz']
        schools_2 = ['João Francisco Rosa', 'Quinzinho de Barros', 'Rosa Cury', "Ary de Oliveira Seabra", "Avelino Leite de Camargo", "Duljara F. de Oliveira", "Genny Kalil Milego", "Inêz Rodrigues Cesarotti", "José Mendes", "Léa Edy Alonso Saliba, Profª", "Maria de Lourdes Ayres de Moraes, Profª", "Maria Domingas Tótora de Góes", "Maria Ignez Figueiredo Deluno, Profª", "Norma Justa Dall'Ara, Profª", 'Oswaldo Duarte', 'Paulo Fernando Nóbrega Tortello', 'Tereza Ciambelli Gianni', 'Walter Carretero', "CEI 10 Eglatina Rocco Perli", "CEI 13 Aluisio de Almeida", "CEI 14 Carlos Reinaldo Mendes, Eng°"]
        if schools_1.include?(school_name)
          if ['Professores', 'Educandos'].include?(segment_name)
            return true
          end
        end
        if schools_2.include?(school_name)
          if segment_name == 'Professores'
            return true
          end
        end
        false
      end
  end
end






