class Donation < ApplicationRecord
  belongs_to :sponsor
  belongs_to :event
end
