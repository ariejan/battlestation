module Battlestation
  class Plan
    attr_accessor :tasks

    def initialize(opts = {}, &block)
      @tasks = {}

      instance_eval &block if block_given?
    end

    def dependency(name, &block)
      tasks[name] = Battlestation::Task.new(name, &block)
    end

    def execute
      status = {}
      tasks.each_pair { |name, task| status[name] = task.execute }
      status
    end
  end
end
