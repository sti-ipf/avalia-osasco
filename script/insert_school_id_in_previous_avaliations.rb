schools = PreviousAvaliation.find_by_sql("SELECT DISTINCT school_name FROM previous_avaliations")

schools.each do |s|
  school = School.first(:conditions => "name LIKE \"%#{s.school_name}%\"")
  if school.nil?
    puts "ESCOLA NAO EXISTE => #{s.school_name}"
  else
    connection = ActiveRecord::Base.connection
    connection.execute("UPDATE previous_avaliations SET school_id = #{school.id} WHERE school_name = \"#{s.school_name}\"")
    connection.execute("UPDATE previous_avaliations SET school_name = \"#{school.name}\" WHERE school_name = \"#{s.school_name}\"")
  end
end