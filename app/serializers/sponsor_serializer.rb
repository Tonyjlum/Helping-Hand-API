class SponsorSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :credit, :total_donations, :email
  has_many :donations

end
