class EventSerializer < ActiveModel::Serializer
  attributes :id, :coordinator_id, :datetime, :description 
end
