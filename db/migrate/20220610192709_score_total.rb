class ScoreTotal < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |u|
      u.integer :total_score
    end
  end
end
