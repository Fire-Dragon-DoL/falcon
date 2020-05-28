module Domain
  module Email
    class Send
      def call(message)
        channel = ::DB::Messaging::Repo.create_channel
        exchange = channel.fanout("#{::DB::Messaging::NS}.emails")
        exchange.publish(message.to_json)
      end

      def self.call(message)
        instance = new
        instance.(message)
      end
    end
  end
end
