module ResqueMaster
  class MQ
    def connection
      return @connection if @connection

      @connection = Bunny.new(
        host:     ResqueMaster.config['host'],
        vhost:    ResqueMaster.config['vhost'],
        username: ResqueMaster.config['username'],
        password: ResqueMaster.config['password']
      )

      @connection.start

      return @connection
    end

    def channel
      @channel ||= connection.create_channel
    end

    def queue
      @queue ||= channel.queue('resque_master', durable: true)
    end

    def exchange
      channel.default_exchange
    end
  end
end
