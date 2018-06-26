class UserController < ApplicationController

  get '/users/:slug' do
  @user = User.find_by_slug(params[:slug])
  erb :'users/show'
  end

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    @user.save
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
     redirect to '/login'
   else
     redirect to '/'
   end
 end
end
