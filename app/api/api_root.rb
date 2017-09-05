require 'app/api/client_api/api'
require 'app/api/admin_api/api'

class ApiRoot < Grape::API
  format :json
  content_type :json, 'application/json'

  before do
    @start = Time.now.to_f
    Application.config.logger.info 'API started'
    Application.config.logger.info({
      url: "#{request.request_method} #{request.path}",
      params: request.params.to_hash.except('route_info')
    })
  end

  after do
    duration = (Time.now.to_f - @start) * 1000
    Application.config.logger.info 'API ended'
    Application.config.logger.info({
      status: status,
      duration: duration.to_i
    })
  end

  mount ClientApi::Api
  mount AdminApi::Api
end
