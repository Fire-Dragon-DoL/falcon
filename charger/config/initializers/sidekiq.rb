Sidekiq.configure_server do |config|
  config.redis = { namespace: "falcon:charger:jobs" }
end

Sidekiq.configure_client do |config|
  config.redis = { namespace: "falcon:charger:jobs"}
end
