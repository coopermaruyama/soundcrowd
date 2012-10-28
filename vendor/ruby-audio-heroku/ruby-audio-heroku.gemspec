# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = 'ruby-audio-heroku'
  s.version     = '1.6.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Khurram Zaman']
  s.email       = ['khurram.zaman@gmail.com']
  s.homepage    = 'https://github.com/khurramzaman/ruby-audio-heroku'
  s.summary     = 'libsndfile wrapper for ruby that works on heroku'
  s.description = 'ruby-audio-heroku wraps around libsndfile to provide simplified sound reading and writing support to ruby programs. it works on heroku.'

  s.files         = Dir['ruby-audio-heroku.gemspec', 'README.rdoc', 'LICENSE', 'Rakefile', 'lib/**/*.rb', 'spec/**/*.{rb,opts,wav,mp3}', 'ext/**/*.{c,h,rb}']
  s.test_files    = Dir['spec/**/*_spec.rb']
  s.extensions    = Dir["ext/**/extconf.rb"]

  s.requirements << ''

  s.has_rdoc         = true
  s.extra_rdoc_files = Dir['README.rdoc', 'ext/**/*.c']
  s.rdoc_options     = ['--line-numbers', '--main', 'README.rdoc']
end
