class FavoritesInn < ApplicationRecord
  belongs_to :favorite_list
  belongs_to :inn
end
