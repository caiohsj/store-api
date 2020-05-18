module Concerns::Notifiable
  extend ActiveSupport::Concern

  def notify_fail(message: nil, params: nil, resource: nil, errors: [])
    notify({message: message, params: params, resource: resource, errors: errors})
  end

  def notify_event(message: nil, params: nil, resource: nil, extra_infos: [])
    notify({message: message, params: params, resource: resource, extra_infos: extra_infos})
  end

  private
    def notify(params)
      begin
        Raven.extra_context(infos: params)
        Raven.capture_exception(params[:message])
      rescue StandardError => e
        puts e.message
        puts e.backtrace.inspect
      end
    end


end

