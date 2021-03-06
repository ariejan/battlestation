module Battlestation
  # This represents a complete Battlestation Plan,
  # it may include checks and tasks.
  class Plan
    # Tasks to perform
    attr_accessor :tasks

    # Create a new plan.
    #
    # @example
    #   Battlestation.plan do
    #     dependency :mysql do
    #       executable 'mysql'
    #     end
    #   end
    def initialize(opts = {}, &block)
      @tasks = {}
      instance_eval &block if block_given?
    end

    # Adds a new task as a dependency.
    def task(name, &block)
      tasks[name] = Battlestation::Task.new(name, &block)
    end
    alias_method :dependency, :task
  end
end
