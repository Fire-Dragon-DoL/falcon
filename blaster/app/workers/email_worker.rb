# frozen_string_literal: true

class EmailWorker
  include Sneakers::Worker
  from_queue 'emails', durable: true

  def work(msg)
    email = JSON.parse(msg)

    GenericMailer.notification(
      email["to"],
      email["subject"],
      email["body"]
    ).deliver_now

    ack!
  end
end
