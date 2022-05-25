require_relative './models/init.rb'
#require_relative './models/user'
require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/activerecord'
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
    'Hello guys!'
  end
end

 # get '/login' do
 #
 #   erb :login
 #
 # end

  #get "/hello/:name" do
  #  @name = params[:name]
  #  erb :hello_template
  #end
#configure do
#
#  set :sessions, true
#
#  set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
#
#end


class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
    end
  end
end

class AddMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :local, index: true, foreign_key: { to_table: :teams }
      t.references :visitor, index: true, foreign_key: { to_table: :teams }
      
      t.timestamps
    end
  end
end

class AddTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name

      t.timestamps
    end
  end
end

class AddForecasts < ActiveRecord::Migration[7.0]
  def change
    create_table :forecasts do |t|
      t.references :user
      t.references :match

      t.integer :local
      t.integer :visitor

      t.timestamps
    end
  end
end

class AddResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results do |t|
      t.references :match

      t.integer :local
      t.integer :visitor

      t.timestamps
    end
  end
end
