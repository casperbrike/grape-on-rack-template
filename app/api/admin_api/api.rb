# Dir['app/api/admin_api/{sample}.rb'].each { |f| require f }

module AdminApi
  class Api < Grape::API
    prefix :admin
  end
end
