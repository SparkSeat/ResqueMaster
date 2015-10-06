require 'resque-scheduler'

module ResqueMaster
  module Plugins
    class ResqueScheduler
      def initialize
        ResqueMaster.add_resque_methods(:enqueue_at, :enqueue_in, :remove_delayed)
      end
    end
  end
end

ResqueMaster.register_plugin(ResqueMaster::Plugins::ResqueScheduler)
