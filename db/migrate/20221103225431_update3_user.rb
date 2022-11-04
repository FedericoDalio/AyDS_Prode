class Update3User < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :facebook, :text
    add_column :users, :twitter, :text
  end
end
