class EventSerializer < ActiveModel::Serializer
  attributes :id, :coordinator_id, :title, :description, :datetime, :long, :lat, :max_volunteers, :current_volunteer_count
  has_many :donations
  has_many :confirms

  def current_volunteer_count
    object.confirms.count
  end
end
