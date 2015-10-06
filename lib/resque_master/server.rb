module ResqueMaster
  class Server
    def subscribe
      mq.queue.subscribe do |_delivery_info, _metadata, payload|
        args = parse_message(payload)
        method = args.shift

        Resque.send(method, *args)
      end
    end

    def run
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
  end
end
