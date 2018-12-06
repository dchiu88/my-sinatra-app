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
      #redirect to login page
    redirect '/login'
    end
  end

  #what routes do I need for signup?
  #this route's job is to render the signup form
  get '/signup' do
   #erb (render a view)
   erb :signup
  end

  post '/users' do
    #here is where we will create a new user and persisthe user to the database
    if params[:name] != "" && params[:user_name=] != "" && params[:password] != ""
      #valid input
      @user = User.create(params)
      session[:user_id] = @user.id
      #go to user show page
      redirect "/users/#{@user.id}"
    else
      redirect '/signup'
    end
  end

  #user SHOW route
  get '/users/:id' do
  #create an instance variable for the user by pulling from the database
    @user = User.find_by(id: params[:id])
    erb :'/users/show'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
