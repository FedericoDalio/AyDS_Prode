class Results < ActiveRecord::Migration[7.0]
  def change
    create_table :results do |t|
      t.references :match
      t.integer :local
      t.integer :visitor
      t.timestamps
    end
  end
end
