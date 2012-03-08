module Battlestation
  module Checks
    class Base
      attr_accessor :name, :type, :opts

      def execute
      end
    end
  end
end

Dir["#{File.expand_path('../checks', __FILE__)}/*.rb"].each do |file|
  require file
end
