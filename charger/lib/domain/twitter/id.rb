# frozen_string_literal: true

module Domain
  module Twitter
    module Id
      def self.to_time(id)
        return SnowflakeId.new(id).to_time.in_time_zone('UTC') if id.is_a?(Integer)

        SnowflakeId.to_snowflake(id).to_time.in_time_zone('UTC')
      end

      def self.to_i(id)
        return id if id.is_a?(Integer)

        SnowflakeId.to_snowflake(id).id
      end
    end
  end
end
