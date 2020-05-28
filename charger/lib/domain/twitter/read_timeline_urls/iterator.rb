require 'domain/twitter'
require 'domain/twitter/get_timeline_urls'

module Domain
  module Twitter
    class ReadTimelineURLs
      class Iterator
        attr_accessor :get_timeline_urls

        def initialize
          @get_timeline_urls = ::Domain::Twitter::GetTimelineURLs::Substitute.build_with_personal_response
        end

        def self.build
          instance = new
          instance.get_timeline_urls = ::Domain::Twitter::GetTimelineURLs.new
          instance
        end

        def call(from, to, client: client, &block)
          messages = get_timeline_urls.(from, to, client: client)

          return if messages.empty?

          # translate here
          messages.each { |message| block.(message) }
          next_since_id = messages.last["id"]
          next_from = SnowflakeId.new(next_since_id).to_time.in_time_zone("UTC")

          return if next_from >= to

          call(next_from, to, client: client, block)
        end
      end
    end
  end
end
