require 'domain/twitter'
require 'domain/twitter/get_timeline_urls'

module Domain
  module Twitter
    class ReadTimelineURLs
      attr_accessor :get_timeline_urls

      def initialize
        @get_timeline_urls = ::Domain::Twitter::GetTimelineURLs::Substitute.build_with_personal_response
      end

      def self.build
        instance = new
        instance.get_timeline_urls = ::Domain::Twitter::GetTimelineURLs.new
        instance
      end

      def call(from, to, client: client)
        Enumerator.new do |iterator|
          messages = get_timeline_urls.(from, to, client: client)

          unless messages.empty?
            next_since_id = messages.last["id"]
            next_from = SnowflakeId.new(next_since_id)
            messages.reject { |message| message["entities"]["urls"].empty? }
          end
        end
        # map data

      end
    end
  end
end
