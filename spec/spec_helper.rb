$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'rubygems'
require 'rspec'
require 'battlestation'

Dir["#{File.expand_path('../support', __FILE__)}/*.rb"].each do |file|
    require file unless file =~ /fakeweb\/.*\.rb/
end

RSpec.configure do |config|
  config.include Spec::Helpers

  config.before :each do
    reset!
  end
end
