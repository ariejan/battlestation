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

    def execute
      executables.each do |executable|
        system("which -s #{executable}")
      end
    end
  end
end
