class ConfirmSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :event_id, :attend
  belongs_to :user
end
