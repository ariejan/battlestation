require 'thor'

require "battlestation/version"
require 'battlestation/plan'
require 'battlestation/dependency'
require 'battlestation/ui'
require 'battlestation/cli'

module Battlestation

  class << self
    attr_writer :ui

    # Plans a new battlestation
    def plan(opts = {}, &block)
      return Plan.new opts, &block
    end

    def ui
      @ui ||= UI.new
    end
  end

end
