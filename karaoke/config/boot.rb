# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])

require 'rails/command'
require 'rails/commands/server/server_command'

module Rails
  class Server
    def default_options
      #super.merge({Port: 10524, Host: '127.0.0.1'})
	    super.merge({Port: 3000, Host: '0.0.0.0'})
    end
  end
end
