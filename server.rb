require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/reloader' 
require_relative './models/init.rb'
require_relative './models/result.rb'
##require_relative './models/user'

if Sinatra::Base.environment == :development  
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

    set :public_folder, 'public'

    get '/' do
      erb :inicio
    end

    get '/login' do
     erb :login
    end

    get '/signup' do
     erb :signup
    end

    get '/play' do
      erb :play
    end

    get '/elegirFecha' do 
      erb :elegirFecha
    end
    
    get '/guardarPrediccion' do
          erb :guardarprediccion
      end


    # implement a login method

    post '/login' do
      user = User.find_by(name: request['username'])
      if user && user.password == request['password']
        session[:user_id] = user.id
        redirect to "/play"
      else
        redirect to "/login"
      end
    end


   post '/signup' do
    if params['username'] != User.find_by(name: request['username']) 
      user = User.create(name:params['username'], password:request['password'], total_score: 0)
     else 
      redirect '/signup'
     end
    end

    post '/elegirFecha' do
      @arreglo = []
      Match.where(date: request['date']).find_each do |match|
         @arreglo.push(match)
        end
      erb :guardarprediccion
     end

     post '/guardarPrediccion' do
      user = User.find_by(id: session[:user_id])
      match1 = Match.find_by(id: params['elige partido'])
        forecast = Forecast.create(user:user ,match:match1, local:request['gol local'].to_i, visitor:request['gol visitante'].to_i, score: 0)
        redirect '/play'
      end




    configure do
      set :sessions, true
      set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
      set :root,  File.dirname(__FILE__)
      set :views, Proc.new { File.join(root, 'views') }
    end

    # Configure a before filter to protect private routes!
    # server.rb

    before do
      if session[:user_id]
        @current_user = User.find_by(id: session[:user_id])
      else
        public_pages = ["/", "/login","/signup"]
        if !public_pages.include?(request.path_info)
          redirect '/login'
        end
      end
    end
  end
end