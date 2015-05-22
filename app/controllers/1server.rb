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


    register do
      def auth(type)
        condition do
          redirect '/user/login' unless send("is_#{type}")
        end
      end
    end

    helpers do
      def is_user?
        @user != nil
      end
    end

    before do
        if session[:user]
            @user = User.get(session[:user][:id])
        end
    end

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