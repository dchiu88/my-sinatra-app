class ResponseEntriesController < ApplicationController

  #get response_entries/new to render a form to create new entry
  get '/response_entries/new' do
    erb :'/response_entries/new'
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

  #This route should send us to journal_entries/edit.erb which will
  #render an edit form
  get '/response_entries/:id/edit' do
    erb :'/response_entries/edit'
  end

  #index route for all responses
  private

   def set_response_entry
   @response_entry = ResponseEntry.find(params[:id])
   end


end
