# schedule_file = "#{Rails.root}/config/schedule.yml"

# raise 'Change me please :)'

# Sidekiq.configure_client do |config|
#   config.redis = { url: "redis://localhost:6379", namespace: "change_here_#{Rails.env}_redis" }
# end

# Sidekiq.configure_server do |config|
#   config.redis = { url: "redis://localhost:6379", namespace: "change_here_#{Rails.env}_redis" }
# end

# if File.exists?(schedule_file) && Sidekiq.server?
#   Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
# end
