module Battlestation
  module Operations
    class Base
      attr_accessor :name, :type, :opts

      def execute
      end
    end
  end
end

Dir["#{File.expand_path('../operations', __FILE__)}/*.rb"].each do |file|
  require file
end
