require 'yaml'

env = defined?(Rails) && Rails.env
CONFIG = YAML.load(File.read(File.expand_path('../../config/app_config.yml', __FILE__)))
CONFIG.merge! CONFIG.fetch(env || :test, {})
