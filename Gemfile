source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

gem 'rails', '~> 5.2.8'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'json'
gem 'figaro'
gem 'faraday'

group :development, :test do
  gem 'vcr'
  gem 'webmock'
  gem 'pry'
  # gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end


group :test do
  gem 'rspec-rails'
  gem 'simplecov'
  gem 'launchy'
  gem 'capybara'
  gem 'orderly'
  gem 'shoulda-matchers'
end


# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
