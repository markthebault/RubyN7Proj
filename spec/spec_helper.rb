ENV['RACK_ENV'] = 'test'
require_relative(File.join('..','app'))
require 'rack/test'

require 'rspec'
require 'active_record'
$:.unshift File.join(File.dirname(__FILE__),'..','lib', 'model')
require_relative '../db/database'


RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end
end

def app
  Sinatra::Application
end
