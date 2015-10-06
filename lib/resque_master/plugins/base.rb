require 'resque'

module ResqueMaster
  module Plugins
    class Base
      def initialize
        ResqueMaster.add_resque_methods(:enqueue)
      end
    end
  end
end

ResqueMaster.register_plugin(ResqueMaster::Plugins::Base)
