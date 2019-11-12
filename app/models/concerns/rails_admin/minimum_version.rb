module RailsAdmin::MinimumVersion
  extend ActiveSupport::Concern
  included do
    rails_admin do
      list do
        field :id
        field :platform
        field :version_number
        field :build_number
        field :required
        field :latest
        field :description
      end

      show do
        field :id
        field :platform
        field :version_number
        field :build_number
        field :required
        field :latest
        field :description
      end

      edit do
        field :platform
        field :version_number
        field :build_number
        field :required
        field :latest
        field :description
      end

      create do
        field :platform
        field :version_number
        field :build_number
        field :required
        field :latest
        field :description
      end
    end
  end
end
