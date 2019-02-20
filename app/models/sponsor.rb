class Sponsor < ApplicationRecord
  has_many :donations
  has_many :events, through: :donations
end
