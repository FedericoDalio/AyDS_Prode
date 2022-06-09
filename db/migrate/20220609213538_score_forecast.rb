class ScoreForecast < ActiveRecord::Migration[7.0]
  def change
    change_table :forecasts do |f|
      f.integer :score
    end
  end
end
