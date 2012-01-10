module IPF
  class GraphicGenerator < Gruff::Bar

    def initialize(size="450x300", options={})
      super(size)

      default_options = {
        :title_font_size => 16,
        :minimum_value => 0,
        :maximum_value => 5,
        :marker_count => 10,
        :sort => false,
        :theme => {
          :colors => ['#3704ba','#bd0004','#f8e900','white'],
          :marker_color => 'black',
          :background_colors => 'white'
        }
      }

      init_options = default_options.merge(options)
      init_options.each do |k, v|
        send("#{k}=", v) unless v.nil?
      end
      # self.legend_font_size = 14
      # self.marker_font_size = 14
      # self.margins=5
      # self.top_margin=0
      # self.legend_box_size=14
      # self.marker_font_size = 18
    end

  end
end
