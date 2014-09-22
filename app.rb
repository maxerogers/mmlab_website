#load gems
require 'sinatra'
require "sinatra/activerecord"
Dir["./models/*.rb"].each { |file| require file }

#load local files
require './config/environments' #database configuration
configure do
  set :server, 'thin'
  enable :sessions
  set :session_secret, "My session secret"
  use OmniAuth::Builder do
    #I know this bad form but I haven't deployed yet. So Shhhhhhhh
    provider :twitter, 'p2xojaAqxCshYaAraH4otANCr', 'TKzK7CRkr71oLRa102V6DF5VQY5BAltvqrkHZWxhXouybcNAxZ'
  end
end

get "/" do
  "welcome"
end

get '/auth/twitter/callback' do
  session[:username] = env['omniauth.auth']['info']['name']
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "p2xojaAqxCshYaAraH4otANCr"
    config.consumer_secret     = "TKzK7CRkr71oLRa102V6DF5VQY5BAltvqrkHZWxhXouybcNAxZ"
    config.access_token        = env['omniauth.auth'][:credentials][:token]
    config.access_token_secret = env['omniauth.auth'][:credentials][:secret]
  end
  "#{env['omniauth.auth']}"
end
