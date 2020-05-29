module Domain
  module Twitter
    class Message
      attr_accessor :date
      attr_accessor :url
      attr_accessor :summary
      attr_accessor :display_url

      def initialize(date, url, summary, display_url)
        @date = date
        @url = url
        @summary = summary
        @display_url = display_url
      end

      def self.build_from_hash(url_hash, message_hash)
        new(
          Time.zone.parse(message_hash["created_at"]).in_time_zone("UTC"),
          url_hash["url"],
          message_hash["text"],
          url_hash["display_url"] || url_hash["url"]
        )
      end

      def to_h
        { date: date, url: url, summary: summary, display_url: display_url }
      end

      def as_json
        {
          "date" => date.iso8601,
          "url" => url,
          "summary" => summary,
          "display_url" => display_url
        }
      end

      def to_json(**opts)
        as_json.to_json(opts)
      end
    end
  end
end
