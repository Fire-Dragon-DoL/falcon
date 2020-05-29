# frozen_string_literal: true

module Domain
  module Email
    class Message
      attr_accessor :to
      attr_accessor :subject
      attr_accessor :body
      attr_accessor :messages

      def initialize(to, messages, subject, body)
        @to = to
        @messages = messages
        @subject = subject
        @body = body
      end

      def subject_interpolated
        template = ::Liquid::Template.parse(subject)
        template.render({ 'messages' => messages_interpolable })
      end

      def body_interpolated
        template = ::Liquid::Template.parse(body)
        template.render({ 'messages' => messages_interpolable })
      end

      def messages_interpolable
        messages.map(&:as_json)
      end

      def as_json
        {
          'to' => to,
          'subject' => subject_interpolated,
          'body' => body_interpolated
        }
      end

      def to_json(**opts)
        as_json.to_json(opts)
      end
    end
  end
end
