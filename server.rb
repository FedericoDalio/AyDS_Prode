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

    get '/cargarResultados' do
      user = User.find_by(id: session[:user_id])
      if (user.name == "admin")
      erb :CargarResultados
      else
        redirect '/play'
      end
    end

    get '/login' do
     erb :login
    end

    get '/signup' do
     erb :signup
    end

    get '/play' do
      user = User.find_by(id: session[:user_id])
      if !(user.name == "admin")
      erb :play
        else
          redirect '/play_admin'
      end
    end

    get '/misPredicciones' do
      erb :misPred1
    end

    get '/elegirFecha' do
      user = User.find_by(id: session[:user_id])
      if !(user.name == "admin") 
      erb :elegirFecha
        else
          redirect '/play_admin'
        end
    end

    get '/elegirFecha2' do 
      erb :elegirFecha2
    end

    get '/tablaGeneral' do 
        @arregloU = []
        User.find_each do |user|
          if !(user.name == "admin") 
            @arregloU.push(user)
          end
        end
        @arregloU = @arregloU.sort_by(&:total_score)
        @arregloU = @arregloU.reverse
      erb :tablaGeneral
    end
    
     get '/verPartidos' do
          erb:verPartidos
      end

     get '/elegirEquipo' do
          erb:elegirEquipo 
     end
	
     get '/perfilEquipo' do
          erb:perfilEquipo
      end
          	
      get '/cierredeSesion' do
        session.delete(:user_id)
        @current_user = nil
        redirect '/'
      end
    
    get '/guardarPrediccion' do
          erb :guardarprediccion
      end

    get '/optional' do 
          erb :optional
        end

    get '/play_admin' do
    user = User.find_by(id: session[:user_id])
      if (user.name == "admin")
      erb :play2
    else
      redirect '/play'
    end
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
      redirect '/login'
     else 
      redirect '/signup'
     end
    end


    post '/elegirFecha' do
      user = User.find_by(id: session[:user_id])
      @arreglo = []
      partidosJugados = []
      predicciones = []
      Result.find_each do |resultado|
          partidosJugados.push(resultado.match)
       end
      Forecast.where(user: user).find_each do |f|
          part = f.match
          predicciones.push(part)
        end
      Match.where(date: request['date']).find_each do |match|
        if (!(partidosJugados.include?(match)) && !(predicciones.include?(match)))
              @arreglo.push(match)
          end
        end
      erb :guardarprediccion
     end

    post '/elegirFecha2' do
      @arreglo = []
      partidosJugados = []
      Result.find_each do |resultado|
          partidosJugados.push(resultado.match)
       end
      Match.where(date: request['date']).find_each do |match|
        if !(partidosJugados.include?(match))
         @arreglo.push(match)
          end
        end
      erb :CargarResultados
     end

    post '/elegirEquipo' do
       @arreglo = []
       Team.where(name: request['nombre']).find_each do |match|
       @arreglo.push(match)
       end
       @partidosJugados = []
       Result.find_each do |resultado|
          @partidosJugados.push(resultado)
       end

       erb :perfilEquipo
    end
    
    post '/perfilEquipo' do
      erb :perfilEquipo
     end
     
     post '/verPartidos' do
      @arreglo = []
      @arreglo2 = []
      Match.where(date: request['date']).find_each do |match|
      partido = Result.find_by(match: match)
        if (partido == nil)
            @arreglo.push(match)
        else
            @arreglo2.push(partido)
          end
      end
      erb :verPartidos2
    end

     post '/misPredicciones' do
      @arreglo = []
      @arreglo2 = []
      Match.where(date: request['date']).find_each do |match|
      partido = Forecast.find_by(match: match)
        if (partido == nil)
            @arreglo.push(match)
        else
            @arreglo2.push(partido)
          end
      end
      erb :misPred2
    end
   

     post '/guardarPrediccion' do

      user = User.find_by(id: session[:user_id])
      match1 = Match.find_by(id: params['elige partido']) 
      forecast = Forecast.create(user:user ,match:match1, local:request['gol local'].to_i, visitor:request['gol visitante'].to_i, score: 0)
      redirect '/optional'
      end


     post '/CargarResultados' do
         user = User.find_by(id: session[:user_id])
         if(user.name=='admin')then
            match1 = Match.find_by(id: params['elige partido'])
            Result.create(match:match1, local:request['gol local'].to_i, visitor:request['gol visitante'].to_i)
            redirect '/play'     
         else   
 	     redirect '/play'
         end
     end
    configure do
      set :sessions, true
      set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
      set :root,  File.dirname(__FILE__)
      set :views, Proc.new { File.join(root, 'views') }
    end

    before do
      if session[:user_id] && session[:user_id]
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
