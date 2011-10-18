module IPF
  class ImportInstrumentsOld
    def emei filename
      File.open(filename, "r") do |infile|
        service_level = ServiceLevel.find_by_name("EMEI/CRECHE")
        while (line = infile.gets)
          cols = line.split("|")
          cols[0] =~ /((\d{1,2}).(\d{1,2}).(\d{1,2})) (.*)"/
          q = Question.create(:number => $4, :service_level => service_level, :indicator => Indicator.find_by_number_and_dimension_id($3, Dimension.find_by_number_and_service_level_id($2, service_level.id).id))
          
          if $5 != "Esta questão não se refere a este segmento."
            QuestionText.create(:text => $5, :question => q, :segment => Segment.find_by_name_and_service_level_id("Familiares", service_level.id))
          end
          
          cols[1] =~ /((\d{1,2}).(\d{1,2}).(\d{1,2})) (.*)"/
          if $5 != "Esta questão não se refere a este segmento."
            QuestionText.create(:text => $5, :question => q, :segment => Segment.find_by_name_and_service_level_id("Funcionários", service_level.id))
          end
          
          cols[2] =~ /((\d{1,2}).(\d{1,2}).(\d{1,2})) (.*)"/
          if $5 != "Esta questão não se refere a este segmento."
            QuestionText.create(:text => $5, :question => q, :segment => Segment.find_by_name_and_service_level_id("Professores e Gestores", service_level.id))
          end
        end
      end
    end

    def emef filename
      File.open(filename, "r") do |infile|
        service_level = ServiceLevel.find_by_name("EMEF")
        while (line = infile.gets)
          cols = line.split("|")
          cols[0] =~ /((\d{1,2}).(\d{1,2}).(\d{1,2})) (.*)"/
          q = Question.create(:number => $4, :service_level => service_level, :indicator => Indicator.find_by_number_and_dimension_id($3, Dimension.find_by_number_and_service_level_id($2, service_level.id).id))
          
          if $5 != "Esta questão não se refere a este segmento."
            QuestionText.create(:text => $5, :question => q, :segment => Segment.find_by_name_and_service_level_id("Educandos", service_level.id))
          end
          
          cols[1] =~ /((\d{1,2}).(\d{1,2}).(\d{1,2})) (.*)"/
          if $5 != "Esta questão não se refere a este segmento."
            QuestionText.create(:text => $5, :question => q, :segment => Segment.find_by_name_and_service_level_id("Familiares", service_level.id))
          end
          
          cols[2] =~ /((\d{1,2}).(\d{1,2}).(\d{1,2})) (.*)"/
          if $5 != "Esta questão não se refere a este segmento."
            QuestionText.create(:text => $5, :question => q, :segment => Segment.find_by_name_and_service_level_id("Funcionários", service_level.id))
          end
  
          cols[3] =~ /((\d{1,2}).(\d{1,2}).(\d{1,2})) (.*)"/
          if $5 != "Esta questão não se refere a este segmento."
            QuestionText.create(:text => $5, :question => q, :segment => Segment.find_by_name_and_service_level_id("Professores e Gestores", service_level.id))
          end
        end
      end
    end

  end
end