$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mail_assertions'

require 'minitest/autorun'

ActionMailer::Base.delivery_method = :test
