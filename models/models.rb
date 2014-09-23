require 'bcrypt'
require 'sinatra/activerecord'
class User < ActiveRecord::Base
  has_secure_password
	validates_presence_of :password, :on => :create
  has_and_belongs_to_many :skills
end

class Skill < ActiveRecord::Base
  has_and_belongs_to_many :users
end
