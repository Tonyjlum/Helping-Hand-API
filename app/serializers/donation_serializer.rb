class DonationSerializer < ActiveModel::Serializer
  attributes :id, :event_id, :sponsor_id, :amount_per_volunteer
end
