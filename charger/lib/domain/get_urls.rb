require 'domain/twitter/get_timeline_urls'

module Domain
  class GetURLs
    attr_accessor :get_timeline_urls

    def initialize
      @get_timeline_urls = ::Domain::Twitter::GetTimelineURLs::Substitute.build_with_personal_response
      # @get_timeline_urls = ::Domain::Twitter::GetTimelineURLs.new
    end

    def call(from, to)
      data = get_timeline_urls.(from, to)
      # map data

    end
  end
end
