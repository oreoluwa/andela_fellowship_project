class InputForms
	attr_accessor(:name, :internal_object)

	def initialize(name)
		@name = name
		@internal_object = Hash.new
	end

	def create_form(name="", attributes={}, values={:conditions => false, :value_if_condition => '', :value_if_not_condition => ''})
		set_name name
		set_attributes attributes
		set_values values
		return prepare
	end

	def set_name name
		if (!name.nil? || name !="")
			@internal_object[:name] = name
			@internal_object[:id] = name
		end
	end

	def set_attributes attributes={}
		attributes.each do |key, val|
			@internal_object[key.to_sym] = val
		end
	end

	def set_values values_option
		if values_option[:conditions]
			@internal_object[:value] = values_option[:value_if_condition]
		else
			@internal_object[:value] = values_option[:value_if_not_condition]
		end

	end

	def prepare
		input_str = "<input "
		@internal_object.each do |key, val|
			input_str << "#{key.to_s}='#{val.to_s}' "
		end
		input_str += "/>"

		return input_str
	end
end