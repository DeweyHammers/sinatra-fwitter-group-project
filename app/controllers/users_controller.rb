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
      redirect '/signup'
    else
      user = User.new(params)
      if params['username'] != '' && params['email'] != '' && params['password'] != ''
        user.save
        session['user_id'] = user.id
        redirect '/tweets'
      else
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
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect '/' 
  end
end
