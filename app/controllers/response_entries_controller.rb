class ResponseEntriesController < ApplicationController

  get '/response_entries' do
    if logged_in?
      @response_entries = ResponseEntry.all
      erb :'/response_entries/index'
    else
      redirect '/'
    end
  end

  get '/response_entries/user_responses' do
    if logged_in?
      @my_response_entries = ResponseEntry.where(user_id: session[:user_id]).pluck(:content)
      erb :'/response_entries/user_responses'
    else
      redirect '/'
    end
  end

  #get response_entries/new to render a form to create new entry
  get '/response_entries/new' do
    if logged_in?
      erb :'/response_entries/new'
    else
      redirect '/'
    end
  end


  #post response_entries to create a new response entry
  post '/response_entries' do
    #create a new entry and save it to the db
    #only save if it has Content
    #only create journal entry if user is logged in
    if !logged_in?
      redirect '/'
    end
    if params[:content] != ""
      @response_entry = ResponseEntry.create(content: params[:content], user_id: current_user.id)
      redirect "/response_entries/#{@response_entry.id}"
    else
      redirect '/response_entries/new'
    end
   end


  #show route for a response
  get '/response_entries/:id' do
    @response_entry = ResponseEntry.find(params[:id])
    set_response_entry
    erb :'/response_entries/show'
  end


  #render an edit form
  get '/response_entries/:id/edit' do
    set_response_entry
    if logged_in?
      if authorized_to_edit?(@response_entry)
        erb :'/response_entries/edit'
      else
        redirect "users/#{current_user.id}"
      end
    else
    redirect '/'
    end
  end

  #apply edits from edit form
  patch '/response_entries/:id' do
  #find journal entry
    set_response_entry
    if logged_in?
      if authorized_to_edit?(@response_entry)
  #modify the journal entry
        @response_entry.update(content: params[:content])
  #redirect to show page
        redirect "/response_entries/#{@response_entry.id}"
      else
        redirect "users/#{current_user.id}"
      end
    else
        redirect '/'
    end
  end

  delete '/response_entries/:id' do
    set_response_entry
    if authorized_to_edit?(@response_entry)
      @response_entry.destroy
      redirect '/response_entries'
    else
      redirect '/response_entries'
    end
  end

end

  #index route for all responses

  private

  def set_response_entry
   @response_entry = ResponseEntry.find(params[:id])
  end
