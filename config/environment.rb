# require your gems
require 'rubygems'
require 'bundler'

Bundler.require

# set the pathname for the root of the app
require 'pathname'
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

# require the controller(s)
#Dir[APP_ROOT.join('app', 'controllers', 'Server.rb')].each { |file| require file }
#Dir[APP_ROOT.join]
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
# require the model(s)
Dir[APP_ROOT.join('app', 'models', '*.rb')].each { |file| require file }

DataMapper.finalize
DataMapper.auto_upgrade!
#DataMapper.auto_migrate!

#require my helpers
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# configure Server settings
class Server < Sinatra::Base
  set :method_override, true
  set :root, APP_ROOT.to_path
  set :views, File.join(Server.root, "app", "views")
  set :public_folder, File.join(Server.root, "app", "public")


end

#map('/'){run Server}