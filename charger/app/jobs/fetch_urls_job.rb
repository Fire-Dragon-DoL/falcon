# frozen_string_literal: true

class FetchUrlsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    client = self.class.twitter
    res = client.home_timeline
    path = Rails.root.join("home_timeline.personal.json")
    File.write(path, res.to_json)
  end

  def self.twitter
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV.fetch("FETCHER_TWT_API_KEY")
      config.consumer_secret = ENV.fetch("FETCHER_TWT_API_SECRET")
      config.access_token = ENV.fetch("FETCHER_TWT_ACCESS_TOKEN")
      config.access_token_secret = ENV.fetch("FETCHER_TWT_ACCESS_TOKEN_SECRET")
    end
  end
end
