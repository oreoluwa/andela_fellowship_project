
class UserManager

	attr_accessor :user

	def initialize()

	end

	def login(username, password)
		user = find_user username
		#if user.password
		return user
	end


	def register(userData)
		#return false if !userData.is_a? Array
		#return false if (userData[:email].nil? && username[:password].nil?)
		#return false if userData[:password].length < 5
		return_var = {}
		password = userData[:password].to_s
		if password.length < 5
			return_var[:errors] = true 
			return return_var
		end
		return_var[:errors] = false
		user = User.create(:email => userData[:email], :name => userData[:name], :password => userData[:password])
		if !user.errors.empty?
			return_var[:errors] = true
			return_var[:error_params] = user.errors
			puts return_var
		    return return_var
		end
		return_var[:user] = user
		return return_var
	end

	def update_user data
		user = find_user(data[:username]) ? find_user(data[:username])  : find_user(data[:email])
		return false if !user
		data.each do |row, update|
			case row
				when :password then
					user.password = update
				when :name then
					user.name = update
			end
		end
		user.save!
	end

	def forgot_password _username
		user = find_by_email(_username) || find_by_username(_username)
		random_password = Array.new(10).map { (65 + rand(58)).chr }.join
		user.password = random_password
		user.save!
		#return

	end

	def find_user data
		user = find_by_email(data) ? find_by_email(data) : find_by_username(data)
		return false if !user
		return user
	end

	def find_by_email email
		user = User.all(:email => email)
		return false if user.nil?
		return user
	end

	def find_by_username _username
		user = User.all(:username => _username)
		return false if user.nil?
		return user
	end
end