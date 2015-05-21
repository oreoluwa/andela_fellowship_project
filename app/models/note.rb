require 'dm-core'
require 'dm-migrations'
require 'dm-validations'

#DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.rb")

class Note
	include DataMapper::Resource

	property :id, Serial
	property :title, String, :required => true
	property :tags, String, :default => 'My note', :required => true
	property :content, Text
	property :created_at, DateTime
	property :last_updated_on, DateTime
	belongs_to :notebook
	#property :notebook, Notebook
end

