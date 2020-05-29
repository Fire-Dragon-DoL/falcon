# frozen_string_literal: true

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
        from = from.in_time_zone('UTC')
        to = to.in_time_zone('UTC')
        since_id = SnowflakeId.to_snowflake(from.to_time).id - 1
        max_id = SnowflakeId.to_snowflake(to.to_time).id

        timeline(session, since_id, max_id)
      end

      def timeline(session, since_id, max_id)
        opts = { since_id: since_id, max_id: max_id, count: 200 }

        return session.home_timeline(**opts).as_json if user_id.nil?

        session.user_timeline(user_id, **opts).as_json
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

        def call(_from, _to, **_opts)
          response
        end

        def self.call(from, to, **_opts)
          instance = new
          instance.(from, to)
        end

        def self.build_with_personal_response
          path = Rails.root.join('home_timeline.personal.json')
          response = Sample.response(path)
          new(response)
        end

        module Sample
          def self.response_path
            Rails.root.join('home_timeline.json')
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
