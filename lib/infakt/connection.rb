require "oauth"
require 'app_config'

module Infakt
  class Connection
    def self.access_token
      @access_token ||= OAuth::AccessToken.new(
        consumer,
        CONFIG['infakt']['access_token'],
        CONFIG['infakt']['access_token_secret']
      )
    end

    def self.consumer
      @consumer ||= OAuth::Consumer.new(
        CONFIG['infakt']['consumer_key'],
        CONFIG['infakt']['consumer_secret'],
        {:site => CONFIG['infakt']['site']}
      )
    end
  end
end
