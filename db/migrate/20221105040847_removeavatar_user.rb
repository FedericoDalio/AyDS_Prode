class RemoveavatarUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :avatar_selected, :int
  end
end
