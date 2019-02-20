class ConfirmSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :event_id, :attend
  has_one :user
end
