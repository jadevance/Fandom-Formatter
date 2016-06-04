require 'simplecov'
SimpleCov.start 'rails'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/spec'
require "minispec-metadata"
# require 'vcr'
# require 'minitest-vcr'
require 'webmock/minitest'
require "minitest/reporters"

# VCR.configure do |c|
#   c.cassette_library_dir = 'test/cassettes'
#   c.hook_into :webmock
# end

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
MinitestVcr::Spec.configure!

class ActiveSupport::TestCase
  fixtures :all

  def setup
   OmniAuth.config.test_mode = true
   
   OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({:provider => 'google_oauth2', :uid => '118416535553028371933', info: { name: 'Jade Vance'}})
  end
end