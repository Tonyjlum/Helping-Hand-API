class SponsorSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :credit, :total_donations
end
