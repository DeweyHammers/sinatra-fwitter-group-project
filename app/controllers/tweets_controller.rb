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
      redirect "/tweets"
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

  get '/tweets/:id/edit' do
    if Helpers.logged_in?(session) 
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])
    if params['content'] != ''
      @tweet.update(content: params['content'])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @user = Helpers.current_user(session)
    if @user.tweets.include?(@tweet)
      @tweet.delete
      redirect '/tweets'
    end
  end
end
