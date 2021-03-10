class UsersController < ApplicationController
  
  get '/signup' do
    if Helpers.logged_in?(session)
      redirect '/tweets'
    else 
      Helpers.set_webpage('signup')
      erb :'users/new'
    end 
  end

  post '/signup' do
    user = User.find_by(username: params['username'], email: params['email'])
    if user
      flash[:message] = "That account has already been made!"
      redirect '/signup'
    else
      user = User.new(params)
      if params['username'] != '' && params['email'] != '' && params['password'] != ''
        user.save
        session['user_id'] = user.id
        flash[:message] = "Account made, Welcome!"
        redirect '/tweets'
      else
        flash[:message] = "There was a error! Please try again."
        redirect '/signup'
      end 
    end
  end

  get '/login' do
    if Helpers.logged_in?(session)
      redirect '/tweets'
    else
      Helpers.set_webpage('login')
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:message] = "Welcome Back!"
      redirect "/tweets"
    else
      flash[:message] = "That was the wrong info!"
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect '/' 
  end
end
