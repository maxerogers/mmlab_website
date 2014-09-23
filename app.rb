#load gems
require 'sinatra'
require "sinatra/activerecord"
require 'omniauth-twitter'
require 'twitter'
require 'httparty'
Dir["./models/*.rb"].each { |file| require file }

#load local files
require './config/environments' #database configuration
configure do
  set :server, 'thin'
  enable :sessions
  set :session_secret, "My session secret"
  use OmniAuth::Builder do
    #I know this bad form but I haven't deployed yet. So Shhhhhhhh
    provider :twitter, 'I6gNM9MZzC0NctgptLDYkW8SE', 't2wGiaqZdCNn0GXbCkkVkXh3jBQB9dcf9gK6D4XKemJ2kFPsN6'
  end
end

get "/" do
  "welcome"
end

get '/search?:skills?' do
  #there must be a smart way to optimize this
  @users = []
  params[:skills].split(',').each do |skill|
    @users.push Skill.where(name: skill).users.to_a
  end
  @users.uniq{|x| x.email}
  @result = ""
  @users.each do |user|
    @result += "#{user.to_s}"
  end
  @result
end

post '/signup' do
  if @user = User.where(email: params[:email])
    "Email is already Registered. Please try another one"
  else
    if params[:password] == params[:password_confirm]
      @user = User.new
      @user.password = params[:password]
      @user.save
      #generateToken
      #send confirmation email
      "Succesful Sign up"
    else
      "Passwords don't match"
    end
  end
end

post '/login' do
  if @user = User.where(email: params[:email])
    if @user.password == params[:password]
      #generateToken
      "Successful Login"
    else
      "Invalid Email or Password"
    end
  else
    "Invalid Email or Password"
  end
end

get '/login/twitter' do
  redirect to("/auth/twitter")
end

get '/auth/failure' do
  params[:message]
end

get '/auth/twitter/callback' do
  session[:username] = env['omniauth.auth']['info']['name']
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "I6gNM9MZzC0NctgptLDYkW8SE"
    config.consumer_secret     = "t2wGiaqZdCNn0GXbCkkVkXh3jBQB9dcf9gK6D4XKemJ2kFPsN6"
    config.access_token        = env['omniauth.auth'][:credentials][:token]
    config.access_token_secret = env['omniauth.auth'][:credentials][:secret]
  end
  "#{env['omniauth.auth']}<br><br>#{env['omniauth.auth'][:credentials][:token]}<br>#{env['omniauth.auth'][:credentials][:secret]}"
end
