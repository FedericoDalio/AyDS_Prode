class UpdateavatarUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :avatar_selected, :int
  end
end
