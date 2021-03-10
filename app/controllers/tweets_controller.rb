class TweetsController < ApplicationController
  get '/tweets' do
    if Helpers.logged_in?(session)
      @users = User.all
      Helpers.set_webpage('index')
      erb :'tweets/index' 
    else
      redirect '/login'
    end
  end
end
