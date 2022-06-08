class AddDate < ActiveRecord::Migration[7.0]
  def change
    change_table :matches do |t| 
      t.integer :date
    end
  end
end
