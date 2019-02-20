class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :credit
  has_many :confirms
end
