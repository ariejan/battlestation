module Battlestation
  class Task
    attr_accessor :name
    attr_accessor :operations

    def initialize(name, &block)
      @name = name
      @operations = []

      instance_eval &block if block_given?
    end

    def title
      "Manning #{name}"
    end

    # Check if an executable exists
    def executable(filename, opts = {})
      operations << Battlestation::Operations::ExecutableCheck.new(filename, opts)
    end

    # Check if a process is running
    def process(identifier, opts = {})
      operations << Battlestation::Operations::ProcessCheck.new(identifier, opts)
    end

    # Run the specified command, fail if unsucessful
    def run(cmd, opts = {})
      operations << Battlestation::Operations::Runner.new(cmd, opts)
    end

    # Execute this dependency
    def execute
      Battlestation.ui.notice("Nothing defined for #{task.name}") and return if operations.empty?

      statuses = []
      # Report successes and failures
      operations.each do |operation|
        status = operation.status
        statuses << status

        Battlestation.ui.send(status[:status], status[:msg])

        if status[:resolution]
          Battlestation.ui.todo(">> " + status[:resolution])
        end

        # Exit if this task failed. No point continuing
        if status[:status] == :fail
          Battlestation.ui.fail(">> Please resolve the failures above and re-run `battlestation`")
          exit 1
        end
      end
    end
  end
end
