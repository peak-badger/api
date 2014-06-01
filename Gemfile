ruby '2.1.0'
source 'https://rubygems.org'

gem 'figaro'
gem 'geohash', git: 'git://github.com/sideshowcoder/geohash.git'
gem 'koala'
gem 'pg'
gem 'rails', '4.1.1'
gem 'rabl-rails'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'spring'
end

group :development, :test do
  gem 'pry'
  gem 'pry-debugger'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'factory_girl_rails'
  gem 'rspec-pride'
  gem 'rspec-rails'
  gem 'shoulda'
  gem 'faker'
end