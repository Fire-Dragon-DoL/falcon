require 'domain/twitter'
require 'domain/twitter/read_timeline_urls/iterator'

module Domain
  module Twitter
    class ReadTimelineURLs
      attr_accessor :iterator

      def initialize
        @iterator = Iterator.new
      end

      def self.build
        instance = new
        instance.iterator = Iterator.build
        instance
      end

      def call(from, to, session: ::Domain::Twitter.session, &block)
        iterator.(from, to, session: session) do |message_hash|
          next if message_hash["entities"]["urls"].empty?

          message_hash["entities"]["urls"].each do |url_hash|
            message = Message.build_from_hash(url_hash, message_hash)

            block.(message)
          end
        end
      end
    end
  end
end
