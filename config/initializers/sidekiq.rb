require 'sidekiq'
require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|
  config.redis = {
    url: "redis://localhost:6379/0"
  }

  schedule_file = "config/sidekiq.yml"
  if File.exist?(schedule_file)
    Sidekiq::Scheduler.dynamic = true

    config.on(:startup) do
      schedule = YAML.load_file(schedule_file)
      env_schedule = schedule[Rails.env.to_sym] || schedule[Rails.env] || {}
      Sidekiq.schedule = env_schedule.fetch(:schedule, {})
      Sidekiq::Scheduler.reload_schedule!
      puts "✅ Sidekiq schedule loaded: #{Sidekiq.schedule.keys}"
    end
  else
    puts "⚠️ No schedule file found at #{schedule_file}"
  end
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: "redis://localhost:6379/0"
  }
end
