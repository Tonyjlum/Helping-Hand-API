class EventSerializer < ActiveModel::Serializer
  attributes :id, :coordinator_id, :title, :description, :datetime, :long, :lat, :donations, :sponsors, :confirms
end
