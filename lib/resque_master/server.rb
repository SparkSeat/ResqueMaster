module ResqueMaster
  class Server
    def subscribe
      mq.queue.subscribe(ack: true) do |delivery_info, _metadata, payload|
        args = parse_message(payload)
        method = args.shift

        Resque.send(method, *args)

        mq.channel.acknowledge(delivery_info.delivery_tag, false)
      end
    end

    def run
      puts 'Welcome to ResqueMaster'

      puts 'Loaded plugins:'
      ResqueMaster.plugins.each do |plugin|
        puts " * #{plugin.class.name}"
      end

      load_enviroment
      subscribe

      loop do
        sleep(1)
      end
    rescue Interrupt
      puts 'Goodbye'
    end

    def parse_message(payload)
      Marshal.load(payload)
    end

    def mq
      @mq ||= ResqueMaster::MQ.new
    end

    # Loads the environment from the given configuration file.
    # Stolen from Redis::CLI
    def load_enviroment(file = nil)
      file ||= '.'

      if File.directory?(file) && File.exist?(File.expand_path("#{file}/config/environment.rb"))
        require 'rails'
        require File.expand_path("#{file}/config/environment.rb")

        if defined?(::Rails) && ::Rails.respond_to?(:application)
          # Rails 3
          ::Rails.application.eager_load!
        end
      elsif File.file?(file)
        require File.expand_path(file)
      end
    end
  end
end
