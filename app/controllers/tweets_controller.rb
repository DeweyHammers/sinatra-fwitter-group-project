class TweetsController < ApplicationController
  get '/tweets' do
    if Helpers.logged_in?(session)
      Helpers.set_webpage('index')
      @users = User.all
      erb :'tweets/index' 
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    erb :'tweets/new' 
  end

  post '/tweets' do
    
  end
end
