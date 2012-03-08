$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'rubygems'
require 'rspec'
require 'battlestation'

Dir["#{File.expand_path('../support', __FILE__)}/*.rb"].each do |file|
  require file unless file =~ /fakeweb\/.*\.rb/
end

RSpec.configure do |config|
  config.include Spec::Path
  config.include Spec::Helpers

  original_wd       = Dir.pwd

  config.before :each do
    reset!
    in_app_root
  end

  config.after :each do
    Dir.chdir(original_wd)
  end
end
