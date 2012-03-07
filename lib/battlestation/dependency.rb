module Battlestation
  class Dependency
    attr_accessor :name

    def initialize(name, &block)
      @name = name
      @block = block
    end
  end
end
