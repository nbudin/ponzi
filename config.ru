# This file is used by Rack-based servers to start the application.

ENV['GEM_PATH'] = "#{File.expand_path('~/.gem')}:#{ENV['GEM_PATH']}"
require '.bundle/environment'

#begin
#  gem 'bundler'
#rescue Gem::LoadError
#  raise "Couldn't load bundler gem.  Gem path is #{Gem.path}"
#end
#require 'bundler'


require ::File.expand_path('../config/environment',  __FILE__)
run Ponzi::Application
