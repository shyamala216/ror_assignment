class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:receive]

  def receive
    
    payload = JSON.parse(request.body.read)

    case payload['event']
    when 'record_created'
      # Handle record creation event
      RecordMailer.notify_created(payload['data']).deliver_now
    when 'record_updated'
      # Handle record update event
      RecordMailer.notify_updated(payload['data']).deliver_now
    else
      # Handle unknown event
    end

    head :ok
  end
end
