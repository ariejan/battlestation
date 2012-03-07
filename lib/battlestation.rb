require "battlestation/version"

require 'battlestation/plan'

module Battlestation
  # Plans a new battlestation
  def self.plan(opts = {}, &block)
    return Battlestation::Plan.new opts, &block
  end
end
