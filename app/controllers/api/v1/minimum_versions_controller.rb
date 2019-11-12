class Api::V1::MinimumVersionsController < Api::ApiController
  def index
    minimum_version = MinimumVersion.order(:updated_at)
                                    .where(platform: minimum_version_params[:platform], latest: true).last
    if minimum_version.present?
      render_success(serialize_resource_list(minimum_version, MinimumVersionSerializer))
    else
      render_no_content
    end
  end

  private

  def minimum_version_params
    params.permit(:platform, :version_number, :build_number, :description, :latest)
  end

end
