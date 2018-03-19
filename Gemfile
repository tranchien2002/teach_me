source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.1.4"
gem "sqlite3"
gem "puma", "~> 3.7"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "bcrypt", "~> 3.1"
gem "bootstrap-sass", "3.3.7"
gem "mysql2", ">= 0.3.18", "< 0.5"
gem "i18n"
gem "jquery-rails", "~> 4.3", ">= 4.3.1"
gem "jquery-ui-rails"
gem "font-awesome-rails"
gem "config"
gem "faker", :git => "https://github.com/stympy/faker.git", :branch => "master"
gem "carrierwave", "1.1.0"
gem "mini_magick", "4.7.0"
gem "i18n-js"
gem "devise", "~> 4.2"
gem "cancancan", "~> 2.0"
gem "ransack", "~> 1.7"
gem "devise-i18n"
gem "omniauth"
gem "omniauth-facebook"
gem "figaro"
gem "kaminari"
gem "bootstrap-kaminari-views"
gem "cocoon"
gem "remotipart", "~> 1.2"
gem "i18n-js"
gem "jquery-validation-rails"
gem "activerecord-import"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
