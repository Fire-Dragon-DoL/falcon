module Domain
  class SendURLs
    attr_accessor :get_timeline_urls
    attr_accessor :send_email

    def initialize
      @get_timeline_urls ||= ::Domain::Twitter::GetTimelineURLs::Substitute.new(
        Rails.root.join("home_timeline.personal.json")
      )
      @send_email ||= ::Domain::Email::Send.new
    end
  end
end
