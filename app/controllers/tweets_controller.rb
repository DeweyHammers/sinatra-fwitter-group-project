class TweetsController < ApplicationController
  get '/tweets' do
    Helpers.set_webpage('tweet_index')
    erb :'tweets/index' 
  end
end
