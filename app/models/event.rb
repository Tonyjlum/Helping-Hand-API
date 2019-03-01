class Event < ApplicationRecord
  has_many :donations, dependent: :delete_all
  has_many :confirms, dependent: :delete_all
  has_many :users, through: :confirms
  has_many :sponsors, through: :donations
end
