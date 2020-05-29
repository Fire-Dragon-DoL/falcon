# frozen_string_literal: true

module DB
  module Messaging
    Repo = Bunny.new.tap(&:start)
    NS = 'falcon'
  end

  Storage = Redis::Namespace.new('falcon:charger', redis: Redis.new)
end
