require 'sinatra/base'
require 'sinatra/reloader'

class Server < Sinatra::Base

    enable :sessions
    #register Sinatra::Flash
    configure :development do
    	register Sinatra::Reloader
    end

    use Rack::Flash#, accessorize: [:error, :success]
    #use Rack::Session::Cookie, secret: "ReallyMustIHaveOne"

    get '/' do
        if !session[:user].nil?
            redirect '/notebook'
        end
        @title = 'Home'
        erb :index, :layout => :layout1
    end


    get '/login' do
      redirect '/user/login'
    end

    get '/register' do
      redirect '/user/register'
    end

      # start the server if ruby file executed directly
      run! if app_file == $0
end