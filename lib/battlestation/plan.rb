module Battlestation
  class Plan
    attr_accessor :dependencies

    def initialize(opts = {}, &block)
      @dependencies = {}

      instance_eval &block if block_given?
    end

    def dependency(name, &block)
      dependencies[name] = Battlestation::Dependency.new(name, &block)
    end

    def execute
      results = []
      dependencies.each_pair { |name, dep| results << dep.execute }
      results.flatten
    end
  end
end
