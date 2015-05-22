ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require_relative "../../config/environment"
require 'minitest/autorun'
require 'rack/test'

class MyAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Server
  end

  def test_root
    get '/'
    assert_equal 200, last_response.status
  end

  def test_homepage_login_redirect
    get '/login'
    assert_equal 302, last_response.status
  end

  def test_homepage_register_redirect
  	get '/register' 
  	assert_equal 302, last_response.status
  end

  def test_user_register_redirect
  	get '/user/register' 
  	assert_equal 200, last_response.status
  end

  def test_user_login_redirect
  	get '/user/login' 
  	assert_equal 200, last_response.status
  end

end