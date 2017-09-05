require_relative './config/application'
require 'irb'

desc 'Run sequel migration'
namespace :db do
  task :migrate do
    Sequel.extension(:migration)
    Sequel::Migrator.run(Application.config.database.connection, 'db/migrations')

    sh "pg_dump --dbname=#{Application.config.database.url} > db/schema.sql"
  end
end

desc 'Run application console'
namespace :app do
  task :console do
    binding.irb
  end
end

namespace :backups do
  desc 'Backup public folder'
  task :public do
    time = Time.now.utc.strftime('%H%M%S%d%m%y')
    filename = "public-#{time}.tar.bz2"

    sh "tar -chjf #{filename} public/"

    dir = Application.config.secrets[:backups_dir]
    sh "mv #{filename} #{dir}"
  end

  desc 'Backup database'
  task :db do
    time = Time.now.utc.strftime('%H%M%S%d%m%y')
    filename = "db-#{time}.sqlite"
    dir = Application.config.secrets[:backups_dir]
    path = File.join dir, filename

    sh "cp db.sqlite #{path}"
  end
end
