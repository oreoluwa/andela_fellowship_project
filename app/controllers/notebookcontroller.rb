
class NotebookController < Server

  get '/' do
    check_can_access

  	@title = 'All NoteBooks'
    @notebooks = get_all_notebooks
  	erb :all_notebooks, :layout => :layout1
  end


  get '/notebook/:notebookid' do |id|
      redirect '/notebook/#{id}'
  end

  get '/note' do
    search_for = params[:search]
    @title = "Search for #{search_for}"
    @note_search_results = User.get(@user.id).notebook.all.notes.all(:content.like => "%#{search_for}%")
    erb :search_page, :layout => :layout1
    #redirect '/'

  end

  get '/:notebookid' do |id|
    check_can_access
    can_access_notebook id


  	notebookid = id.to_i
    @notebook = get_notebook notebookid
    @notetitle = ''
    @notecontent = ''
    @notetags = ''
    @usernotes = @notebook.notes
    @params = false
    @method = 'POST'
    @input_form = InputForms.new('notebook')
    @note_action_btn = 'new_note_btns'
    @action_url = "/notebook/note/#{notebookid}/new"
  	erb :notebook, :layout => :layout1
  end

  get '/note/:notebookid/:id' do |notebookid, id|
    check_can_access
    can_access_note(notebookid, id)

  	notebookid = notebookid.to_i
  	noteid = id.to_i
    @method = 'PUT'
    @notebook = get_notebook notebookid
    @note = @notebook.notes.get(noteid)
  	@title = @note.title
    @notetitle = @title
    @notecontent = @note.content
    @notetags = @note.tags
    @params = true
    @input_form = InputForms.new('note')
    @note_action_btn = 'edit_btns'
    @action_url = "/notebook/note/#{notebookid}/#{noteid}"
    erb :notebook, :layout => :layout1
  end

  post '/new' do
    check_can_access
    notebook = Notebook.create(user_id: session[:user][:id], title: params[:title], description: params[:description], last_updated_on: Time.now)
    notebook.save!
    puts notebook.to_s
    redirect '/notebook'
  end


  post '/note/:notebookid/new' do
    check_can_access
    notebookid = params[:notebookid].to_i
    can_access_notebook notebookid
    #note = Note.create(title: params[:title], content: params[:content], tags: params[:tags], notebook_id: notebookid)
    note = Note.new
    note.title = params[:title]
    note.content = params[:content]
    note.tags = params[:tags]
    note.notebook_id = notebookid
    note.save!
    redirect "/notebook/note/#{notebookid}/#{note.id}"
  end

  put '/:notebook_id' do |notebook_id|
    check_can_access
    can_access_notebook notebook_id
  end

  put '/note/:notebookid/:id' do |notebookid, id|
    check_can_access
    can_access_note(notebookid, id)

    note = get_note(notebookid, id)
    note.title = params[:title]
    note.content = params[:content]
    note.tags = params[:tags]
    note.save!
    redirect "/notebook/note/#{notebookid}/#{note.id}"
  end

  delete '/note/:notebookid/:id' do
    notebookid = params[:notebook]
    noteid = params[:id]
    can_access_note(notebookid, noteid)
    
    note = get_note(notebookid, noteid)
    note.destroy!
    redirect "/notebook/#{notebookid}"

  end

  def check_can_access
    if !@user
      #puts "I cant post to db here"
      redirect '/user/login'
    end
  end

  def can_access_notebook notebook_id
    user = @user.id
    if !User.get(user).notebook.get(notebook_id)
      redirect '/notebook'
    end
  end

  def can_access_note(notebook_id, note_id)
    user = @user.id
    if !User.get(user).notebook.get(notebook_id).notes.get(note_id)
      redirect '/notebook'
    end
  end

  def get_all_notebooks
    user = @user.id
    return User.get(user).notebook.all
  end

  def get_notebook notebook_id
    user = @user.id
    return User.get(user).notebook.get(notebook_id)
  end

  def get_all_notes notebook_id
    user = @user.id
    return User.get(user).notebook.get(notebook_id).notes.all
  end

  def get_note notebook_id, note_id
      user = @user.id
      return User.get(user).notebook.get(notebook_id).notes.get(note_id)
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end