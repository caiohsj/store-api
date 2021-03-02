source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

#Backend
gem 'mysql2', '>= 0.4.4'
gem 'rails', '~> 6.0.2'
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'admin_model'

# Sidekiq
gem 'sidekiq'
gem 'sidekiq-cron', '~> 1.1'
gem 'sidekiq-status'
gem 'redis-namespace'
gem 'redis'

# Descomentar caso sua aplicaçao for ter front-end
# Assets
gem 'sass-rails', '~> 5'
# https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# gem 'turbolinks', '~> 5'

# Facilities
gem 'devise'
gem 'jera_push', git: 'https://github.com/jera/jera-push'
gem 'business_process'
gem 'rails_admin', '~> 2.0'
gem 'cpf_cnpj'
gem 'enumerize'

# API
gem 'active_model_serializers', '~> 0.10.0'
gem 'rack-cors', require: 'rack/cors'
gem 'pagy', '~> 3.2', '>= 3.2.1'
gem 'jbuilder', '~> 2.7'
gem 'oj'
gem 'modulejs-rails'
gem 'gem-wrappers', '~> 1.4.0'

# Image upload
gem 'carrierwave', '~> 2.0'
gem 'carrierwave-aws'
gem 'rmagick'

# Monitoring
gem 'sentry-raven'
gem 'newrelic_rpm'

# MR Automators
gem 'danger-gitlab'
gem 'danger-rubocop'
gem 'reek'
gem 'danger-reek', :git => "https://github.com/VictorCostaOliveira/danger-reek"

# Facebook
gem 'koala', '~> 3.0'
gem 'omniauth-facebook', '~> 4.0'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'mina'
  gem 'mina-sidekiq'
end

group :test do
  gem 'selenium-webdriver'
  gem 'webdrivers', '~> 3.0'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
