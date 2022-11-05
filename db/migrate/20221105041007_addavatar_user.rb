class AddavatarUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :avatar_selected, :text
  end
end
