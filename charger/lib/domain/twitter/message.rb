module Domain
  module Twitter
    class Message
      attr_accessor :date
      attr_accessor :url
      attr_accessor :summary

      def initialize(date, url, summary)
        @date = date
        @url = url
        @summary = summary
      end

      def to_h
        { date: date, url: url, summary: summary }
      end

      def as_json
        {
          "date" => date.iso8601,
          "url" => url,
          "summary" => summary
        }
      end

      def to_json(**opts)
        as_json.to_json(opts)
      end
    end
  end
end
