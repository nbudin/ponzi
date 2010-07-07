# This file is used by Rack-based servers to start the application.

ENV['GEM_PATH'] = "#{File.expand_path('~/.gem')}:#{ENV['GEM_PATH']}"
require 'rubygems'
require 'bundler'


require ::File.expand_path('../config/environment',  __FILE__)
run Ponzi::Application
