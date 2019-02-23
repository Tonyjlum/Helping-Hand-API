class Event < ApplicationRecord
  has_many :donations, dependent: :destroy
  has_many :confirms, dependent: :destroy
  has_many :users, through: :confirms
  has_many :sponsors, through: :donations
end
