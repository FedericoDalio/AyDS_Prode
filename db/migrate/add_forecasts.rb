class AddForecasts < ActiveRecord::Migration[7.0]
  def change
    create_table :forecasts do |t|
      t.references :user
      t.references :match
      t.integer :local
      t.integer :visitor
      t.timestamps
    end
  end
end
