class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :credit, :confirm_event_info

  def confirm_event_info
    object.confirms.map {|confirm|
      {confirm: confirm, event: confirm.event}
    }
  end
end
