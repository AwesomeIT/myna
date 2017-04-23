require 'yaml'
require 'active_record'


connection = if ENV.fetch('KARAFKA_ENV', '').downcase.include?('production')
  { production: { adapter: 'postgres',
                  url: ENV['DATABASE_URL'] } }
else
  YAML.load(File.open('./config/database.yml'))
end

ActiveRecord::Base.establish_connection(
  connection[ENV['KARAFKA_ENV']]
)

require 'kagu'