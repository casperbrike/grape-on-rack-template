require 'logger'
require 'yaml'

$: << Dir.pwd
env = (ENV['RACK_ENV'] || :development)

require 'bundler'
Bundler.require :default, env.to_sym
require 'active_support'

module Application
  include ActiveSupport::Configurable
end

Application.configure do |config|
  config.root = Dir.pwd
  config.env = ActiveSupport::StringInquirer.new(env.to_s)
  config.secrets = YAML.load(File.read("config/secrets.yml"))[config.env]
  config.logger = Logger.new($stdout) if config.env != 'test'
end

db_config = YAML.load(File.read("config/database.yml"))[Application.config.env]

Application.config.database = Hashie::Mash.new
Application.config.database.config = db_config
Application.config.database.url = "postgresql://#{db_config['username']}:#{db_config['password']}@#{db_config['host']}/#{db_config['database']}"

Application.config.database.connection = Sequel.postgres db_config
Application.config.database.connection.extension(:pagination)
Application.config.database.connection.loggers << Logger.new($stdout) if Application.config.env != 'test'

specific_environment = "config/environments/#{Application.config.env}.rb"
require specific_environment if File.exists? specific_environment
Dir["config/initializers/**/*.rb"].each {|f| require f}
