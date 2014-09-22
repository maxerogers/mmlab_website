#load gems
require 'sinatra'
#load local files
require './config/environments' #database configuration

get "/" do
  "welcome"
end
