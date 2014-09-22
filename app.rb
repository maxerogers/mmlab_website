#load gems
require 'sinatra'
require "sinatra/activerecord"
Dir["./models/*.rb"].each { |file| require file }

#load local files
require './config/environments' #database configuration

get "/" do
  "welcome"
end
