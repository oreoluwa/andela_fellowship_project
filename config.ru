require 'bundler'
require 'sinatra/base'
require 'sinatra/flash'

require File.expand_path('../config/environment',  __FILE__)


map('/notebook'){ run NotebookController}
map('/user'){ run UserController}
map('/'){run Server }

#map('/user'){ run }
#run Server