class UserSerializer < ActiveModel::Serializer
  attributes :id, :id, :email, :token, :name

  def token
    scope[:token]
  end

end
