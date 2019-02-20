class SponsorSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :credit, :total_donations
  has_many :donations
end
