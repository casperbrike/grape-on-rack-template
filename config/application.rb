require_relative './environment'
Dir["app/{lib,uploaders,models,serializers}/**/*.rb"].each { |file| require file }
require 'app/api/api_root'

ApplicationServer = Rack::Builder.new {
  use Rack::SslEnforcer

  if Application.config.env == 'development'
    use Rack::Static, :urls => ["/development"], :root => "public"
  end

  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: :any
    end
  end


  map "/api" do
    run ApiRoot
  end
}
