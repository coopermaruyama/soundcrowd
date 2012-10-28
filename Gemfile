source 'https://rubygems.org'

gem 'rails', '3.2.1'

gem "fog", "~> 1.3.1"
gem 'sass'
gem "backbone-on-rails"
gem 'haml'
gem "devise"
gem "resque"
gem "ancestry"

gem "waveform", :git => "git://github.com/coopermaruyama/waveform.git" #for creating waveform images
gem "oily_png" #png manipulation for waveform
gem "ffmpeg" #for converting to wav
gem 'ruby-audio-heroku', :git => "git://github.com/khurramzaman/ruby-audio-heroku.git"
# gem "icanhasaudio", :git => "git://github.com/harukasan/icanhasaudio.git"

gem "carrierwave"       #handle uploads
gem "carrierwave_direct"
gem "aws-s3"

gem "randexp"
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem "jquery-fileupload-rails"
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :production do 
  gem 'pg'
end

group :development do
  gem 'rspec-rails', ">= 2.8.1"
  gem "factory_girl_rails", '3.3.0'
  gem 'guard-rspec'
  gem 'annotate', '~> 2.4.1.beta'
end

group :test do
  gem 'rspec-rails', ">= 2.8.1"
  gem "factory_girl_rails", '3.3.0'
  gem "cucumber-rails", ">= 1.2.1"
  gem "database_cleaner"
  gem 'spork', '0.9.0'
  gem 'capybara'
  gem 'growl'
end

group :test, :development do
  gem "faker"
  gem 'sqlite3'
end