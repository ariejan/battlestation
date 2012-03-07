require 'rubygems/user_interaction'

module Battlestation
  class UI
    def warn(message, newline = nil)
    end

    def debug(message, newline = nil)
    end

    def error(message, newline = nil)
    end

    def info(message, newline = nil)
    end

    def confirm(message, newline = nil)
    end

    class Shell < UI
      attr_writer :shell

      def initialize(shell)
        @shell = shell
        @quiet = false
      end

      def warn(message, newline = nil)
        tell_me(message, :yellow, newline)
      end

      def debug(message, newline = nil)
        tell_me(message, nil, newline) if debug?
      end

      def error(message, newline = nil)
        tell_me(message, :red, newline)
      end

      def info(message, newline = nil)
        tell_me(message, nil, newline) if !@quiet
      end

      def confirm(message, newline = nil)
        tell_me(message, :green, newline) if !@quiet
      end

      def debug?
        !!@debug && !@quiet
      end

      def debug!
        @debug = true
      end

      def be_quiet!
        @quiet = true
      end

      private
      def tell_me(msg, color = nil, newline = nil)
        newline.nil? ? @shell.say(msg, color) : @shell.say(msg, color, newline)
      end
    end
  end
end

