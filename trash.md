use Rack::Session::Cookie
use Warden::Manager do |manager|
    manager.default_strategies :password
    manager.failure_app = UserController
    manager.serialize_into_session {|user| user.id}
    manager.serialize_from_session{|id| Datastore.for(:user).find_by_id(id)}
end

Warden::Manager.before_failure do |environment, options|
    environment['REQUEST_METHOD'] = 'POST'
end

Warden::Strategies.add(:password) do
        def valid?
          params["email"] || params["password"]
        end

        def authenticate!
          user = Datastore.for(:user).find_by_email(params['email'])
          if user && user.authenticate(params['password'])
            success!(user)
          else
            fail!('Error with your log in')
          end
        end
    end


    def warden_handler
        env['warden']
    end

  def current_user
    warden_handler.user
  end

  def check_authentication
    redirect '/login' unless warden_handler.authenticated?
  end


  Warden::Strategies.add(:password) do
      def flash
        env['x-rack.flash']
      end

      # valid params for authentication
      def valid?
        params['user'] && params['user']['username'] && params['user']['password']
      end

      # authenticating user
      def authenticate!
        # find for user
        user = User.first(username: params['user']['username'])
        if user.nil?
          fail!("Invalid username, doesn't exists!")
          flash.error = ""
        elsif user.authenticate(params['user']['password'])
          flash.success = "Logged in"
          success!(user)
        else
          fail!("There are errors, please try again")



          
    use Warden::Manager do |config|
        config.serialize_into_session{|user| user.id}
        config.serialize_from_session{|id| User.get(id)}
        config.scope_defaults :default,
        strategies: [:password],
        action: '/login'
        config.failure_app = UserController
    end

    Warden::Manager.before_failure do |env,opts|
        env['REQUEST_METHOD'] = 'POST'
    end


    Warden::Strategies.add(:password) do
    def valid?
      params["email"] || params["password"]
    end
 
    def authenticate!
      user = User.first(:email => params['email'])
        if !user.nil?
            fail!('Wrong Email & Password')
        elsif user && user.authenticate(params["password"])
            success!(user)
        else
            fail!("Could not log in")
        end
      end
    end
    