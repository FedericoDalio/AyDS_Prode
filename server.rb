require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require_relative './models/init'
require_relative './models/result'
require 'sinatra/flash'
# #require_relative './models/user'

if Sinatra::Base.environment == :development
  # Configuration server.
  class App < Sinatra::Application
    configure :development do
      register Sinatra::Reloader
      after_reload do
        puts 'Reloaded...'
      end
    end

    def initialize(_app = nil)
      super()
    end

    set :public_folder, 'public'

    get '/' do
      erb :inicio
    end
 
    get '/cambiarContrasenia' do
      erb :cambiarContrasenia
    end


    get '/cargarResultados' do
      user = User.find_by(id: session[:user_id])
      if user.name == 'admin'
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
      if user.name != 'admin'
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
      if user.name != 'admin'
        erb :elegirFecha
      else
        redirect '/play_admin'
      end
    end

    get '/elegirFecha2' do
      erb :elegirFecha2
    end

    get '/tablaGeneral' do
      @arreglo_u = []
      User.find_each do |user|
        @arreglo_u.push(user) unless user.name == 'admin'
      end
      @arreglo_u = @arreglo_u.sort_by(&:total_score)
      @arreglo_u = @arreglo_u.reverse
      erb :tablaGeneral
    end

    get '/verPartidos' do
      erb :verPartidos
    end

    get '/elegirEquipo' do
      erb :elegirEquipo
    end

    get '/perfilEquipo' do
      erb :perfilEquipo
    end

    get '/miPerfil' do
      erb :miPerfil
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
      if user.name == 'admin'
        erb :play2
      else
        redirect '/play'
      end
    end

    get '/modificarMiPerfil' do
      erb :modificarMiPerfil
    end

    # implement a login method

    post '/login' do
      user = User.find_by(name: request['username'])
      if user && user.password == request['password']
        session[:user_id] = user.id
        redirect to '/play'
      else
        redirect to '/login'
      end
    end

    post '/signup' do
      if params['username'] != User.find_by(name: request['username'])
        User.create(name: params['username'], password: request['password'], total_score: 0, description: " ", email: " ", facebook: " ", twitter: " ", avatar_selected: "1")

        redirect '/login'
      else
        redirect '/signup'
      end
    end

    post '/elegirFecha' do
      user = User.find_by(id: session[:user_id])
      @arreglo = []
      partidos_jugados = []
      predicciones = []
      Result.find_each do |resultado|
        partidos_jugados.push(resultado.match)
      end
      Forecast.where(user: user).find_each do |f|
        part = f.match
        predicciones.push(part)
      end
      Match.where(date: request['date']).find_each do |match|
        @arreglo.push(match) if !partidos_jugados.include?(match) && !predicciones.include?(match)
      end
      erb :guardarprediccion
    end

    post '/elegirFecha2' do
      @arreglo = []
      partidos_jugados = []
      Result.find_each do |resultado|
        partidos_jugados.push(resultado.match)
      end
      Match.where(date: request['date']).find_each do |match|
        @arreglo.push(match) unless partidos_jugados.include?(match)
      end
      erb :CargarResultados
    end

    post '/elegirEquipo' do
      @arreglo = []
      Team.where(name: request['nombre']).find_each do |match|
        @arreglo.push(match)
      end
      @partidos_jugados = []
      Result.find_each do |resultado|
        @partidos_jugados.push(resultado)
      end

      erb :perfilEquipo
    end

    post '/perfilEquipo' do
      erb :perfilEquipo
    end


    post '/miPerfil' do
      erb :miPerfil
    end

    post '/modificarMiPerfil' do

      gambler = User.find_by(id: session[:user_id])
      json = request.params 
      logger.info json 
      logger.info gambler

      #gambler.update(facebook: request['facebook'])
      
      gambler.email = request['email']
      gambler.facebook = request['facebook']
      gambler.twitter = request['twitter']
      gambler.description = request['description']

      #cadena_avatar = request['avatar']
      #cadena_avatar.chars.last(1).join
      #gambler.avatar_selected = cadena_avatar

      #gambler.avatar_selected = request['avatar'][9]

      gambler.avatar_selected = request['avatar_selected']
      gambler.save  #Guardado de valores nuevos


      redirect '/miPerfil'
      #erb :modificarMiPerfil
    end
    
    
    post '/cambiarContrasenia' do
      gambler = User.find_by(name: request['username'])
      json = request.params 
      logger.info json 
      logger.info gambler
      if(gambler && (request['password'] == request['passwordconfirm'])) #Confirma que las contraseñas sean iguales
        gambler.password = (json['passwordconfirm']) #Cambio de valor
        gambler.save  #Guardado de valor nuevo
        redirect '/login'
      else
        redirect '/signup'
      end
    end
   
    post '/verPartidos' do
      @arreglo = []
      @arreglo2 = []
      Match.where(date: request['date']).find_each do |match|
        partido = Result.find_by(match: match)
        if partido.nil?
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
        if partido.nil?
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
      Forecast.create(user: user, match: match1, local: request['gol local'].to_i, visitor: request['gol visitante'].to_i, score: 0)
      redirect '/optional'
    end

    post '/CargarResultados' do
      user = User.find_by(id: session[:user_id])
      if user.name == 'admin'
        match1 = Match.find_by(id: params['elige partido'])
        Result.create(match: match1, local: request['gol local'].to_i, visitor: request['gol visitante'].to_i)
      end
      redirect '/play'
    end
    configure do
      set :sessions, true
      set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
      set :root,  File.dirname(__FILE__)
      set :views, proc { File.join(root, 'views') }
    end

    before do
      if session[:user_id]
        @current_user = User.find_by(id: session[:user_id])
      else
        public_pages = ['/', '/login', '/signup']
        redirect '/login' unless public_pages.include?(request.path_info)
      end
    end
  end
end
