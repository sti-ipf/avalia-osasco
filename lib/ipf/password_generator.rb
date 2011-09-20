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

    private
      def genpass( len )
        chars = ("a".."h").to_a + ["j", "k"] + ("m".."z").to_a + ["0"] + ("2".."9").to_a
        newpass = ""
        1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
        return newpass
      end
  end
end

