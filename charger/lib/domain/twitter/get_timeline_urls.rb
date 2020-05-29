require 'domain/twitter'

module Domain
  module Twitter
    class GetTimelineURLs
      # XXX: user_timeline is easier for testing due to lower rate limiting
      attr_accessor :user_id

      def initialize(user_id = nil)
        @user_id = user_id
      end

      def call(from, to, session: ::Domain::Twitter.session)
        since_id = SnowflakeId.to_snowflake(from.to_time).id - 1
        max_id = SnowflakeId.to_snowflake(to.to_time).id

        timeline(session, since_id, max_id)
      end

      def timeline(session, since_id, max_id)
        if user_id.nil?
          return session.home_timeline(
            since_id: since_id,
            max_id: max_id,
            count: 200
          ).as_json
        end

        session.user_timeline(
          user_id,
          since_id: since_id,
          max_id: max_id,
          count: 200
        ).as_json
      end

      def self.call(from, to, session: ::Domain::Twitter.session)
        instance = new
        instance.(from, to, session: session)
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
