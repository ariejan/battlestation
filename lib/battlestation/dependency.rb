module Battlestation
  class Dependency
    attr_accessor :name
    attr_accessor :checks

    def initialize(name, &block)
      @name = name
      @checks = []

      instance_eval &block if block_given?
    end

    def executable(filename, opts = {})
      checks << Battlestation::Checks::Executable.new(filename, opts)
    end

    def process(identifier, opts = {})
      checks << Battlestation::Checks::Process.new(identifier, opts)
    end

    # Execute this dependency
    def execute
      checks.collect(&:status)
    end
  end
end
