module Battlestation
  class Dependency
    attr_accessor :name
    attr_accessor :executables

    def initialize(name, &block)
      @name = name
      @executables = []

      instance_eval &block if block_given?
    end

    def executable(filename)
      executables << filename
    end

    # Execute this dependency
    #
    # @return [Array<Hash<Symbol, String>>] an array with status hashes.
    def execute
      result = []

      executables.each do |executable|
        if system("/usr/bin/env which #{executable} &> /dev/null")
          result << { okay: "#{executable} found" }
        else
          result << { fail: "#{executable} not found" }
        end
      end

      result
    end
  end
end
