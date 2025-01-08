class FavoriteList < ApplicationRecord
  belongs_to :user
  has_many :favorites_inns
  has_many :inns, through: :favorites_inns

  validates :name, presence: true
end
