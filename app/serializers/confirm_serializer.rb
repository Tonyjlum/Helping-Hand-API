class ConfirmSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :event_id, :attendee_name, :attendee_email, :attend

  def attendee_name
    object.user.first_name + " " + object.user.last_name
  end

  def attendee_email
    object.user.email
  end

end
