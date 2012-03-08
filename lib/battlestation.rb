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
