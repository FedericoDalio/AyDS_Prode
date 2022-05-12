require "sinatra/activerecord/rake"

​

namespace :db do

  task :load_config do

    require "./server"

  end

end
