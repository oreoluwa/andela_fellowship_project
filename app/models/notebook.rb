require 'dm-core'
require 'dm-migrations'


class Notebook
	include DataMapper::Resource
	property :id, Serial
	property :title, String, :default => 'My notebook', :required => true
	property :created_at, DateTime, :default => Time.now
	property :description, String, :default => 'My Amazing Notes'
	property :last_viewed, DateTime
	property :last_updated_on, DateTime
	belongs_to :user, :required => true
	has n, :notes, 'Note', :child_key => 'notebook_id' #:constraint => :destroy

	#property :owner, Strin
	#has 

	def get_id
		return self[:id]
	end

	def get_title
		return self[:title]
	end

	def set_title(title_)
		self[:title] = title_
		return self
	end

	def get_created_at
		return self[:created_at]
	end

	def set_created_at(created_)
		self[:created_at] = created_
		return self
	end

	def get_description
		return self[:description]
	end

	def set_description(description_)
		self[:description] = description_
		return self
	end

	def get_last_viewed
		return self[:last_viewed]
	end

	def set_last_viewed(last_viewed_)
		self[:last_viewed] = last_viewed_
		return self
	end

	def get_last_updated_on
		return self[:last_updated_on]
	end

	def set_last_updated_on(last_updated_)
		self[:last_updated_on] = last_updated_
		return self
	end
end


