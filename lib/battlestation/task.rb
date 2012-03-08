module Battlestation
  class Task
    attr_accessor :name
    attr_accessor :operations

    def initialize(name, &block)
      @name = name
      @operations = []

      instance_eval &block if block_given?
    end

    def executable(filename, opts = {})
      operations << Battlestation::Operations::ExecutableCheck.new(filename, opts)
    end

    def process(identifier, opts = {})
      operations << Battlestation::Operations::ProcessCheck.new(identifier, opts)
    end

    # Execute this dependency
    def execute
      operations.collect(&:status)
    end
  end
end
