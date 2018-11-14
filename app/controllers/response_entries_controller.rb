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

  #index route for all responses


end
