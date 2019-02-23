class DonationSerializer < ActiveModel::Serializer
  attributes :id, :event_id, :amount_per_volunteer
  belongs_to :sponsor
  belongs_to :event

end
