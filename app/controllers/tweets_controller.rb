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
    if Helpers.logged_in?(session) 
      erb :'tweets/new'
    else
      redirect '/login'
    end 
  end

  post '/tweets' do
    @user = Helpers.current_user(session)
    if params['content'] != ''
      @user.tweets << Tweet.create(params)
    else
      redirect '/tweets/new' 
    end
  end

  get '/tweets/:id' do
    if Helpers.logged_in?(session) 
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect '/login'
    end 
  end

  get '/tweet/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit'
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.delete
    redirect '/tweets'
  end
end
