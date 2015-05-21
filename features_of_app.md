User
	Notebook
		create, edit, get, delete
		properties <date_created, last_updated, last_view>
		default
	Note
		create, edit, get, delete
		properties <notebook, date_created, last_updated, content, description, title #indexing>
		
	User
		profile 
			create, edit, get, delete
			properties <name, date_sign_up, social_auth, password(bcrypt), >
		authentication
			
			login page routes -> login controller -> auth_services -> 
			
			registration page routes -> reg controller -> reg services->
			
		