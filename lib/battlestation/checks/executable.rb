module Battlestation
  module Checks
    class Executable < Base
      attr_accessor :filename

      def initialize(filename, opts = {})
        @filename = filename
        @type     = :executable
        @name     = "executable-#{filename}"
        @opts     = opts
      end

      def status
        if executable_exists?
          { status: :okay, msg: "#{filename} executable found", name: name }
        else
          { status: :fail, msg: "#{filename} executable not found", resolution: opts[:resolution], name: name }
        end
      end

      private
      def executable_exists?
        files = %x(/usr/bin/env which #{filename}).split
        return files.any? && File.executable?(files.first)
      end
    end
  end
end

