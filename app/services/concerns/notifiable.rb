module Concerns::Notifiable
  extend ActiveSupport::Concern

  def notify_fail(message: nil, params: nil, resource: nil, errors: [])
    notify({message: message, params: params, resource: resource, errors: errors}, :excepetion)
  end

  def notify_event(message: nil, params: nil, resource: nil, extra_infos: [])
    notify({message: message, params: params, resource: resource, extra_infos: extra_infos}, :event)
  end

  private
    def notify(params, kind)
      begin
        Raven.extra_context(infos: params)
        if kind.eql?(:event)
          Raven.send_event(params)
        else
          Raven.capture_exception(params[:message])
        end
      rescue StandardError => e
        puts e.message
        puts e.backtrace.inspect
      end
    end
end

