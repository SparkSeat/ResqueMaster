require 'bunny'

require 'resque_master/version'
require 'resque_master/mq'

module ResqueMaster
  extend self

  # Public
  #
  # Define a resque method that should be proxied. For example, you may wish
  # to add methods that `resque-scheduler` defines.
  #
  # Example:
  #   ResqueMaster.add_resque_method(:enqueue_in)
  #
  # You can then call that method on ResqueMaster
  #
  # It is highly recommended you define these in a plugin (see plugins/base
  # and plugins/resque_scheduler)
  #
  # Example:
  #   ResqueMaster.enqueue_in(5.days, SendFollowupEmail)
  def add_resque_methods(*method_names)
    method_names.each do |method_name|
      define_method(method_name) do |*args|
        run_on_master(method_name, *args)
      end
    end
  end

  # Public
  #
  # Send a method to the resque master to be dealt with.
  #
  # Example:
  #   ResqueMaster.run_on_master(:enqueue, ALongJob)
  def run_on_master(method_name, *args)
    message = [method_name, args].flatten
    mq.exchange.publish(Marshal.dump(message), routing_key: mq.queue.name)
  end

  def register_plugin(plugin)
    plugin.new
  end

  private

  def mq
    @mq ||= ResqueMaster::MQ.new
  end
end

require 'resque_master/plugin_loader'
require 'resque_master/plugins/base'
