# import user into server.rb
# server.rb
require_relative 'models/user'
require 'bundler/setup'
require 'sinatra/base'
require "sinatra/activerecord"
require 'sinatra/reloader' if Sinatra::Base.environment == :development  

class App < Sinatra::Application
  configure :development do
    register Sinatra::Reloader
    after_reload do
      puts 'Reloaded...'
    end
  end

  def initialize(app = nil)
    super()
  end

  get '/' do
    'Hola mundo cruel!!!'
  end
end

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
    end
  end
end