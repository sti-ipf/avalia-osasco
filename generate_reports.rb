
class GenerateReports

  def example
    i = Institution.find(4)
    sl = ServiceLevel.find(2)
    g = i.users.first.group
    
    mean = {} 
    mean_group = {}
    mean_sl = {}
    indicator = {}
    indicator_group = {}
    indicator_sl = {}
    parties = {}
    questions_sl = {}
    questions_group = {}
    questions = {} 

    Dimension.all.each do |d|
      mean_sl[d.id] =  Institution.mean_dimension_by_sl(d,sl)
      mean_group[d.id] = Institution.mean_dimension_by_group(d,sl,g)
      mean[d.id] = i.mean_dimension(d,sl)

      d.indicators.all do |i|
        questions_sl[i.id] = {}
        questions_group[i.id] = {}
        questions[i.id] = {} 
        indicator[i.id] = Institution.mean_indicator_by_sl(i,sl)
        indicator_group[i.id] = Institution.mean_indicator_by_group(i,sl,g)
        indicator_sl[i.id] = i.mean_indicator(i,sl)
        questions_sl[i.id].merge(mean_questions_parties_by_sl(i,sl))
        questions_group[i.id].merge(Institution.mean_questions_parties_by_group(i,sl,g))
        questions[i.id].merge(Institution.mean_questions_indicator(indicator,service_level))
      end
    end
    
    { 
      :dimensions => { :mean => mean , :mean_group => mean_group , :mean_sl => mean_sl },
      :indicators => { :mean => indicator , :mean_group => indicator_group , :mean_sl => indicator_sl },
      :parties => { :mean_sl => questions_sl, :mean_group => questions_group,:mean => questions }
    }
  end
end
