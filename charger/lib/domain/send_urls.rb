# frozen_string_literal: true

require 'domain/twitter/read_timeline_urls'
require 'domain/email/send'
require 'domain/email/message'

module Domain
  class SendURLs
    attr_accessor :read_timeline_urls
    attr_accessor :send_email

    def initialize
      @read_timeline_urls = ::Domain::Twitter::ReadTimelineURLs.new
      @send_email = ::Domain::Email::Send::Substitute.new
    end

    def self.build
      instance = new
      instance.read_timeline_urls = ::Domain::Twitter::ReadTimelineURLs.build
      instance.send_email = ::Domain::Email::Send.new
      instance
    end

    def self.call(start_date, end_date, to_email, _subject, _body)
      instance = build
      instance.(start_date, end_date, to_email)
    end

    def call(start_date, end_date, to_email, subject, body)
      messages = []
      read_timeline_urls.(start_date, end_date) { |msg| messages << msg }

      email = ::Domain::Email::Message.new(to_email, messages, subject, body)

      send_email.(email)
    end
  end
end
