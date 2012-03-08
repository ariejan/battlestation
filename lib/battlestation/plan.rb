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
      status = {}
      dependencies.each_pair { |name, dep| status[name] = dep.execute }
      status
    end
  end
end
