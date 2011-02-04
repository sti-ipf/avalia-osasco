module UniFreire
  module Graphs
    class Dimensions < UniFreire::Graphs::Base
      def initialize(size, institution, service_level, dimension, options={})
        super(size, options)
        @dimension = dimension
        @service_level = service_level
      end

      def make
        data_sl = Institution.mean_dimension_by_sl(@dimension, @service_level)
        sl_time = Time.now - now
        now = Time.now
        # p data_sl

        p "Graph Dimension: #{d.number}.#{d.name}"

        g = @institution.users.first(:conditions => {:service_level_id => @service_level.id}, :include => :group).group
        data_group = Institution.mean_dimension_by_group(d, @service_level, g)
        group_time = Time.now - now
        now = Time.now

        # p data_group

        data = @institution.mean_dimension(d,@service_level)
        dimension_time = Time.now - now
        now = Time.now

        graph = @institution.graph(data, data_group, data_sl, @service_level, :id => "d#{dnumber}")
      end
    end
  end
end

