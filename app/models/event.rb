class Event < ApplicationRecord
  has_many :donations, dependent: :destroy
  has_many :confirms, dependent: :destroy
  has_many :users, through: :confirms
end
