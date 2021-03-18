require Rails.root.join('lib', 'rails_admin', 'abstract_model' ,'statement_builder.rb')

RailsAdmin.config do |config|
  config.main_app_name = ['WebTemplate', 'Admin']

  # config.authorize_with do
  #   authenticate_or_request_with_http_basic('WebTemplate') do |username, password|
  #     username == 'admin' &&
  #     password == 'secret123'
  #   end
  # end

  config.actions do
    dashboard
    index
    new
    bulk_delete
    show
    edit
    delete
  end
end
