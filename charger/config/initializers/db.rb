module DB
  Storage = Redis.new
  Messaging = Bunny.new
  NS = "falcon:charger"
end
