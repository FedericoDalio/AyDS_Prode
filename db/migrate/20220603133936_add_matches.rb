class AddMatches < ActiveRecord::Migration[7.0]
  def change

    create_table :matches do |t|

      t.references :local, index: true, foreign_key: { to_table: :teams }

      t.references :visitor, index: true, foreign_key: { to_table: :teams }

      t.timestamps
    end
  end
end
