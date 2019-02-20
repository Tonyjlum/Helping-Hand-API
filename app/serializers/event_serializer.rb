class EventSerializer < ActiveModel::Serializer
  attributes :id, :coordinator_id, :datetime, :description
  has_many :donations
  has_many :confirms

end
