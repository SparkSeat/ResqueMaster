module ResqueMaster
  class MQ
    def connection
      return @connection if @connection

      @connection = Bunny.new
      @connection.start

      return @connection
    end

    def channel
      @channel ||= connection.create_channel
    end

    def queue
      @queue ||= channel.queue('resque_master', auto_delete: true)
    end

    def exchange
      channel.default_exchange
    end
  end
end
