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
      return @channel if @channel && @channel.open?
      fail ResqueMaster::MQFailure, 'MQ connection is not open' unless connection.open?

      @channel = connection.create_channel
    end

    def queue
      fail ResqueMaster::MQFailure, 'MQ channel is not open' unless channel.open?

      @queue ||= channel.queue('resque_master', durable: true)
    end

    def exchange
      fail ResqueMaster::MQFailure, 'MQ channel is not open' unless channel.open?

      channel.default_exchange
    end
  end
end
