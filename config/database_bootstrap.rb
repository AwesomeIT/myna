require 'yaml'
require 'kagu'

ActiveRecord::Base.establish_connection(
  YAML.load(File.open('./config/database.yml'))[ENV['KARAFKA_ENV']]
)