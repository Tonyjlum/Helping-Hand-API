class EventSerializer < ActiveModel::Serializer
  attributes :id, :coordinator_id,:coordinator_name, :title, :description, :datetime, :long, :lat, :max_volunteers, :current_volunteer_count
  has_many :donations
  has_many :confirms

  def current_volunteer_count
    object.confirms.count
  end

  def coordinator_name
    user = User.find_by(id: object.coordinator_id)
    user.first_name + " " + user.last_name
  end
end
