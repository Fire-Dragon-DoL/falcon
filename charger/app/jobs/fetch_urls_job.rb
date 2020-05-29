# frozen_string_literal: true

require 'domain/send_urls'

class FetchUrlsJob < ApplicationJob
  queue_as :default

  def perform(timeline_request)
    # TODO: Use `build` to run on the Twitter API
    send_urls = ::Domain::SendURLs.new

    send_urls.(
      timeline_request.start_date,
      timeline_request.end_date,
      timeline_request.to,
      timeline_request.subject,
      timeline_request.body
    )
  end
end
