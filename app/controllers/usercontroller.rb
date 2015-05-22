#require 'sinatra/flash'

class UserController < Server


    get '/' do
      #user profile here
    end

    get '/:id/profile' do |id|
      user_id = id.to_i
    	@user = User.get(user_id)
    end

    get '/login' do
      logged_in

      @input_form = InputForms.new('login')
      @params = session[:error_login_message] if session[:error_login_message]
      erb :login, :layout => :layout1
    end

    get '/register' do
      logged_in

      @input_form = InputForms.new('register')
      @params = flash[:error_user_object] if flash[:error_user_object]
      erb :register, :layout => :layout1
    end

    get "/logout" do
      session[:user] = nil
      redirect '/'
    end

=begin
    put '/user/profile' do
      user = UserManager.new
      redirect '/user/profile' if !params.nil?
      user.update_user(params)
      userId = user.id
      redirect "/user/#{userId}/profile"
    end
=end

    post '/login' do
      logged_in

      if !params 
        redirect '/user/login'
      end

      session[:error_login_message] = nil
      user = User.first(:conditions => {:email => params[:email]})

      #puts user.to_s
      if !user && user.password != params[:password]
        return_params = {error_message: 'Unknown Username and Password', email: params[:email] }
        session[:error_login_message] = return_params
        redirect '/user/login'
      else
        session[:user] = {}
        session[:user][:id] = user.id
        session[:user][:name] = user.name
        redirect '/notebook'
      end

    end
=begin
    post '/forgot_password' do

    end
=end
    post '/register' do
      logged_in
      #if no  user data redirect
      if !params
        redirect '/user/register'
      end
      user_manager = UserManager.new
      return_var = user_manager.register(params)
      if return_var[:errors] == true
        error_response = {username: params[:username], password: params[:password], name: params[:name], email: params[:email]}
        error_response[:errors] = []
        if !return_var[:error_params].nil?
          return_var[:error_params].each do |error, c|
            error_response[:errors] << error
          end
        end
        session[:error_user_object] = error_response
        redirect '/user/register'
      else
        session[:user] = {}
        session[:user][:id] = return_var[:user].id
        session[:user][:name] = return_var[:user].name
        #session[:user] = return_var
        redirect '/'      
      end
    end

    put '/user/:id' do |id|
      if 
        redirect '/notebook'
      end

    end

    put '/user/:id/profile' do |id|
      if flash[:user_logged_in]
        redirect '/notebook'
      end
  	
    end

    def logged_in
      redirect '/notebook' if !session[:user].nil?
    end

    def is_valid_user?
      if !session[:user]
        return false
      end
    end


  # start the server if ruby file executed directly
  run! if app_file == $0
end