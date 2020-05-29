# frozen_string_literal: true

module Domain
  module Twitter
    def self.session
      ::Twitter::REST::Client.new do |config|
        config.consumer_key = ENV.fetch('FETCHER_TWT_API_KEY')
        config.consumer_secret = ENV.fetch('FETCHER_TWT_API_SECRET')
        config.access_token = ENV.fetch('FETCHER_TWT_ACCESS_TOKEN')
        config.access_token_secret = ENV.fetch('FETCHER_TWT_ACCESS_TOKEN_SECRET')
      end
    end
  end
end
