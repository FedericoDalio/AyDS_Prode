class UpdateTeams3 < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :linkContent, :text
  end
end
