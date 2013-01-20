require 'yaml'

env = defined?(Rails) && Rails.env

path = '../../config/app_config.yml'
path = '../../config/app_config.yml.example' unless File.exists?(path)

CONFIG = YAML.load(File.read(File.expand_path(path, __FILE__)))
CONFIG.merge! CONFIG.fetch(env || :test, {})
