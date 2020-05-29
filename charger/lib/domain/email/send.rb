# frozen_string_literal: true

module Domain
  module Email
    class Send
      def call(message)
        channel = ::DB::Messaging::Repo.create_channel
        exchange = channel.default_exchange

        exchange.publish(
          message.to_json,
          routing_key: "emails"
        )
      end

      def self.call(message)
        instance = new
        instance.(message)
      end

      class Substitute
        def call(message)
          Rails.logger.info(message.as_json.inspect)
        end

        def self.call(message)
          instance = new
          instance.(message)
        end
      end
    end
  end
end
