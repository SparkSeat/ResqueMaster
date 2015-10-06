require 'resque'

module ResqueMaster
  module Plugins
    # This is a simple plugin that adds Resque's `enqueue` method
    class Resque
      def initialize
        ResqueMaster.add_resque_methods(:enqueue)
      end
    end
  end
end

ResqueMaster.register_plugin(ResqueMaster::Plugins::Resque)
