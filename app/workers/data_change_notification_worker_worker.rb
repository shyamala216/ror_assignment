class DataChangeNotificationWorkerWorker
  include Sidekiq::Worker

  def perform(id)
    user=User.find_by(id: id)
    return unless user
    # Do something
    YourApp::Application::THIRD_PARTY_API_ENDPOINTS.each do |key,endpoint|

      response = HTTParty.post(endpoint, body: user.to_json, headers: {'Content-Type' => 'application/json'})
      puts "Notification sent to #{key}: #{response.code}"
    end
  end
end
