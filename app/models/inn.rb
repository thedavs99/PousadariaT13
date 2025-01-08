class Inn < ApplicationRecord
  validates :name, :registration_number, presence: true, on: :create
  validates :name, :registration_number, :description, presence: true, on: :update
  validates :registration_number, uniqueness: true

  belongs_to :inn_owner
  has_one :address
  has_many :inn_rooms
  has_many :favorites_inns
  has_many :favorite_lists, through: :favorites_inns
  accepts_nested_attributes_for :address
  delegate :full_address, to: :address

  scope :active, -> { where(active: true)}
end
