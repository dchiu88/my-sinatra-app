class UsersController < ApplicationController

  #what routes do I need for login?

  #the purpose of this route is to render the login page
  get '/login' do
    erb :login
  end

  # the purpose of this route is to receive the login form.
  # find the user, and log the user in (create a session)
  post '/login' do
    #Find the user
    @user = User.find_by(user_name:params[:user_name])
    #Authenticate the user
    @user.authenticate(params[:password])
    #undefined method "authenticate for nil:NilClass
    if @user.authenticate(params[:password])
    #log the user in
    session[:user_id] = @user.id
    #redirect to the user's landing page
    puts session
    redirect "users/#{@user.id}"
  else
    #tell user they entered invalid credentials
    #redirect to login page
  end
end

  #what routes do I need for signup?
  get '/signup' do
  end

  #user SHOW route
  get '/users/:id' do
    "this will be the user show route"
  end
end
