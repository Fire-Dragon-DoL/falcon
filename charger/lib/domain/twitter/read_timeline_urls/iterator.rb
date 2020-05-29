# frozen_string_literal: true

require 'domain/twitter'
require 'domain/twitter/get_timeline_urls'
require 'domain/twitter/id'
require 'domain/twitter/message'

module Domain
  module Twitter
    class ReadTimelineURLs
      class Iterator
        attr_accessor :get_timeline_urls
        attr_accessor :delay

        def initialize(delay = nil)
          @delay = delay
          @get_timeline_urls = GetTimelineURLs::Substitute.build_with_personal_response
        end

        def self.build(delay = 1.0)
          instance = new(delay)
          instance.get_timeline_urls = GetTimelineURLs.new
          instance
        end

        def self.call(from, to, session: ::Domain::Twitter.session, &block)
          instance = build
          instance.(from, to, session: session, &block)
        end

        def call(from, to, session: ::Domain::Twitter.session, &block)
          messages = get_timeline_urls.(from, to, session: session)

          return if messages.empty?

          next_since_id = messages.last['id'] + 1
          next_from = Id.to_time(next_since_id)

          messages.each do |message|
            block.(message)
          end

          return if next_from >= to || next_from <= from

          sleep(delay) unless delay.nil?
          call(next_from, to, session: session, &block)
        end
      end
    end
  end
end
