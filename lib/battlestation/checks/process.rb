module Battlestation
  module Checks
    class Process < Base
      attr_accessor :identifier

      def initialize(identifier, opts = {})
        @identifier = identifier
        @type       = :process
        @name       = "process-#{identifier}"
        @opts       = opts
      end

      def status
        if process_running?
          { status: :okay, msg: "#{identifier} up and running", name: name }
        else
          { status: opts[:error] ? :fail : :warn, msg: "#{identifier} not running", resolution: opts[:resolution], name: name }
        end
      end

      private
      def process_running?
        processes = %x(ps aux | grep -i #{identifier} | grep -v grep).split
        return processes.any?
      end
    end
  end
end
