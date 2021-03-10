class TweetsController < ApplicationController
  get '/tweets' do
    Helpers.set_webpage('index')
    erb :'tweets/index' 
  end
end
