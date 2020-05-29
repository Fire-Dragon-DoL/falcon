# frozen_string_literal: true

require 'domain/send_urls'

class FetchUrlsJob < ApplicationJob
  queue_as :default

  def perform(timeline_request)
    # Use `new` to run on mocked data
    send_urls = ::Domain::SendURLs.build

    send_urls.(
      timeline_request.start_date,
      timeline_request.end_date,
      timeline_request.to,
      timeline_request.subject,
      timeline_request.body
    )
  end
end
