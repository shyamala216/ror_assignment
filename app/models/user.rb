class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 255}
  validates :password, presence:true, :length => {:within => 8..12}

  after_create :send_created_notification
  after_update :send_updated_notification
  
  require 'httparty'

  private

  def send_created_notification
    data = { "event": 'record_created', "data": {id: self.id, name: self.name} }
      HTTParty.post('http://localhost:3001/webhooks/receive', body: data.to_json)
  end

  def send_updated_notification
    data = { "event": 'record_updated', "data": {id: self.id, name: self.name} }

    HTTParty.post('http://localhost:3001/webhooks/receive', "data": { id: self.id, name: self.name })
  end
end
