class MinimumVersionSerializer < ActiveModel::Serializer
  attributes :id, :platform, :version_number, :build_number,  :required, :description

end
