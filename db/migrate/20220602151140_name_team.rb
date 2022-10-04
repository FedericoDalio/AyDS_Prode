class NameTeam < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name
    end
  end
end
