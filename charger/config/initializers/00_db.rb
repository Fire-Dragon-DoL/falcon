module DB
  Messaging = Bunny.new
  Storage = Redis::Namespace.new("falcon:charger", redis: Redis.new)
end
