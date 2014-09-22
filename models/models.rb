require 'bcrypt'
require 'sinatra/activerecord'
class User < ActiveRecord::Base
  include BCrypt
end
