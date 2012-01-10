# -*- encoding : utf-8 -*-
require 'spec_helper'

describe IPF do
  it 'first test' do

    # g = Gruff::Bar.new(600)
    # g.title = "Gráfico de exemplo" 

    # g.data("2010", [1, 2, 3, 4, 2])
    # g.data("2011", [5, 5, 3, 3, 4])
    # g.theme = {
    #         :colors => ['#3704ba','#bd0004','#f8e900','white'],
    #         :marker_color => 'black',
    #         :background_colors => 'white'
    #       }

    # g.labels = {0 => 'Familiares', 1 => 'Funcionários', 2 => 'Gestores', 3 => 'Professores', 4 => 'Geral'}

    
    # g.write("#{Rails.root.to_s}/tmp/graph_example.png")

    data, labels = ReportData.indicator_graphic_data(88)

    g = Gruff::Bar.new("450x300")
    g.title = "Amizade e solidariedade" 

    g.data("2011", data)
    g.data("2010", [1, 2, 3, 4, 2])
    
    g.theme = {
            :colors => ['#3704ba','#bd0004','#f8e900','white'],
            :marker_color => 'white',
            :background_colors => 'white'
          }

    g.labels = labels
    g.labels[labels.length] = "Geral"

    
    g.write("#{Rails.root.to_s}/tmp/graph_example.png")
    
  end

end



