class User < ApplicationRecord
  has_many :confirms
  has_many :events, through: :confirms
end
