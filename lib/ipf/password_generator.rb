module IPF
  class PasswordGenerator
    def generate
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

private
    def genpass( len )
      chars = ("a".."h").to_a + ["j", "k"] + ("m".."z").to_a + ["0"] + ("2".."9").to_a
      newpass = ""
      1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
      return newpass
    end
  end
end

