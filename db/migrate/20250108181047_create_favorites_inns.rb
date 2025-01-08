class CreateFavoritesInns < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites_inns do |t|
      t.references :favorite_list, null: false, foreign_key: true
      t.references :inn, null: false, foreign_key: true

      t.timestamps
    end
  end
end
