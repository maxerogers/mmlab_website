#load gems
require 'sinatra'
require "sinatra/activerecord"
#load local files
require './config/environments' #database configuration

get "/" do
  "welcome"
end
