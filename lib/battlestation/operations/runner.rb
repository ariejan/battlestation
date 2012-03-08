module Battlestation
  module Operations
    class Runner < Base
      attr_accessor :cmd

      def initialize(cmd, opts = {})
        @cmd  = cmd
        @type = :runner
        @name = "runner-#{cmd.split(" ").first}"
        @opts = opts
      end

      def status
        Battlestation.ui.notice "Executing `#{cmd}`"

        if system("#{cmd} &> /dev/null")
          { status: :okay, msg: "`#{cmd}` executed successfully", name: name }
        else
          { status: :fail, msg: "`#{cmd}` failed to execute", name: name }
        end
      end
    end
  end
end
