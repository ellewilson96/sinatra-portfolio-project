class UserController < ApplicationController

  get '/users/:slug' do
  @user = User.find_by_slug(params[:slug])
  erb :'users/show'
  end

  get '/signup' do
   if !logged_in?
     erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
   else
     redirect to '/flights'
   end
 end

 post '/signup' do
   if params[:username] == "" || params[:email] == "" || params[:password] == ""
     erb :'/users/create_user', locals: {message: "All fields must be complete to sign up."}
   else
     @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
     @user.save
     session[:user_id] = @user.id
     redirect to '/flights'
   end
 end
  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/flights'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
   if logged_in?
     session.destroy
     redirect to '/'
   else
     redirect to '/'
   end
 end
end
