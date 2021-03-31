class Api::ApiController < ActionController::API
  include ApiTokenAuthenticatable
  include ApiCommonResponses

  # after_action :build_headers_if_needed!

  respond_to :json

  protected

  def serialize_resource(resource, serializer, scope: nil)
    JSON.parse(serializer.new(resource, scope: scope).to_json)
  end

  def serialize_resource_list(resources, serializer)
    JSON.parse(ActiveModelSerializers::SerializableResource.new(resources, each_serializer: serializer).to_json)
  end

  def serialize_fixed_values(values)
    values
  end

end
