class DonationSerializer < ActiveModel::Serializer
  attributes :id, :event_id, :sponsor_id, :amount_per_volunteer, :sponsor_name, :event_title, :event_description, :max_volunteers, :current_number_of_confirms, :number_of_attended, :total_donation_for_event, :event_datetime

  def sponsor_name
    "#{object.sponsor.first_name} #{object.sponsor.last_name}"
  end

  def event_title
    object.event.title
  end

  def event_description
    object.event.description
  end

  def max_volunteers
    object.event.max_volunteers
  end

  def current_number_of_confirms
    object.event.confirms.count
  end

  def number_of_attended
    object.event.confirms.select{ |c| c.attend}.count
  end

  def total_donation_for_event
    number_of_attended * object.amount_per_volunteer
  end
  def event_datetime
    object.event.datetime
  end

end
