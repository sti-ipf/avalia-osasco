require "test/test_helper"

class GraphTest < ActiveSupport::TestCase

  test "gerar um gráfico" do
    # 266 - 1.1
    # 283, 329 - 3.3
    ReportData.service_level_indicator_graph(IndicatorsParty.find(283), ServiceLevel.all(:conditions => "id IN (3,4)"))
#    ReportData.service_level_indicators_graph(Dimension.find_by_number(3),ServiceLevel.all(:conditions => "id IN (3,4)"))

  end

end

