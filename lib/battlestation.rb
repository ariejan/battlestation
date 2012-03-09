require 'thor'

require "battlestation/version"
require 'battlestation/plan'
require 'battlestation/task'
require 'battlestation/operations'
require 'battlestation/ui'
require 'battlestation/cli'

module Battlestation
  class << self
    attr_writer :ui

    # Load the Battlestation or Battlestation.rb file
    def load(filename)
      plan = eval(File.read(filename))
      return plan
    rescue SyntaxError, NameError
      Battlestation.ui.error("Your Battlestation has syntax errors.")
      return nil
    rescue
      Battlestation.ui.error("Some error occured, but we're not sure what happened.")
      return nil
    end

    # Plan a new battlestation
    #
    # See README for details
    def plan(opts = {}, &block)
      return Plan.new opts, &block
    end

    # UI output
    def ui
      @ui ||= UI.new
    end
  end
end
