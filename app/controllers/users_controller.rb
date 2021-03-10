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
      flash[:notice] = "That account has already been made!"
      redirect '/signup'
    else
      user = User.new(params)
      if params['username'] != '' && params['email'] != '' && params['password'] != ''
        user.save
        session['user_id'] = user.id
        flash[:notice] = "Account made, Welcome!"
        redirect '/tweets'
      else
        flash[:notice] = "There was a error! Please try again."
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

  get '/logout' do
    session.clear
    redirect '/' 
  end
end
