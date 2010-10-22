ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

require 'mocha'
require 'test/spec'
require 'test/spec/rails'
require 'test/spec/rails/macros'
require 'test/spec/share'
require 'test/spec/add_allow_switch'

Net::HTTP.add_allow_switch :start
TCPSocket.add_allow_switch :open

Mocha::Configuration.prevent(:stubbing_non_existent_method)
Mocha::Configuration.prevent(:stubbing_method_unnecessarily)

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  fixtures :all
  
  $:.unshift(File.expand_path('../', __FILE__))
  
  # require 'test_helper/temporary_file_directory'
  # include TestHelper::TemporaryFileDirectory
end
