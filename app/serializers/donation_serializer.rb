class DonationSerializer < ActiveModel::Serializer
  attributes :id, :event_id, :sponsor_id, :amount_per_volunteer, :sponsor_name

  def sponsor_name
    "#{object.sponsor.first_name} #{object.sponsor.last_name}"
  end

end
