$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'

SimpleCov.start

if ENV['CI']
  # Upload code coverage reports on CI
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require 'mail_assertions'
require 'minitest/autorun'

ActionMailer::Base.delivery_method = :test
