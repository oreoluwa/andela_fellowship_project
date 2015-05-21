require 'dm-core'
require 'dm-migrations'
require 'dm-timestamps'
require 'dm-validations'
require 'bcrypt'

class User
  	include DataMapper::Resource
  	include BCrypt

	property :id, Serial
	property :name, String
	property :social_auth_id, String
	property :social_auth_provider, String
	property :email, String, :format => :email_address, :required => true, unique: true
	property :username, String, :length => 3..50, unique: true
	property :password, BCryptHash, :length => 5..60, :required => true
	has n, :notebook, 'Notebook', :child_key => 'user_id'

	validates_length_of :password, :minimum => 5

	def authenticate(password)
		self.password == password
	end
end 