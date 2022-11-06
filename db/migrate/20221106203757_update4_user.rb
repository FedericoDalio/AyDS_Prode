class Update4User < ActiveRecord::Migration[7.0]
  def change
     add_column :users, :preguntaseguridad, :text
    add_column :users, :respuestaseguridad, :text
  end
end
