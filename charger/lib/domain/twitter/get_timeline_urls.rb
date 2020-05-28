require 'domain/twitter'

module Domain
  module Twitter
    class GetTimelineURLs
      def call(from, to, client: ::Domain::Twitter.client)
        since_id = SnowflakeId.to_snowflake(from.to_time).id - 1
        max_id = SnowflakeId.to_snowflake(to.to_time).id

        client.home_timeline(
          since_id: since_id,
          max_id: max_id,
          count: 200
        )
      end

      def self.call(from, to, client: ::Domain::Twitter.client)
        instance = new
        instance.(from, to, client: client)
      end

      class Substitute
        attr_accessor :response

        def initialize(response = Sample.response)
          @response = response
        end

        def call(from, to, **opts)
          response
        end

        def self.call(from, to, **opts)
          instance = new
          instance.(from, to)
        end

        def self.build_with_personal_response
          path = Rails.root.join("home_timeline.personal.json")
          response = Sample.response(path)
          new(response)
        end

        module Sample
          def self.response_path
            Rails.root.join("home_timeline.json")
          end

          def self.response(path = nil)
            path ||= response_path
            text = File.read(path)
            JSON.parse(text)
          end
        end
      end
    end
  end
end
