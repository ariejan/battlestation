module Battlestation
  class CLI < Thor
    include Thor::Actions

    def initialize(*)
      super

      the_shell = (options["no-color"] ? Thor::Shell::Basic.new : shell)
      Battlestation.ui = UI::Shell.new(the_shell)

      Battlestation.ui.info("Manning battlestation...")
      Battlestation.ui.info("")
    end

    check_unknown_options!

    default_task :check
    class_option "no-color", :type => :boolean, :banner => "Disable colorization in output"

    def help
      Battlestation.ui.info "Create 'Battlestatio'n in the root of your project and run 'battlestation check'"
    end

    desc :check, "Checks your system for all dependencies"
    long_desc <<-D
      Checks if you have all the necessary dependencies installed and running
      in order to run this project.
    D
    def check
      plan = nil
      filenames = ["Battlestation", "Battlestation.rb"].select { |f| File.exists?(f) }

      case filenames.size
      when 0
        Battlestation.ui.error "Could not read your Battlestation file"
        exit 1
      when 1
        plan = Battlestation.load(filenames.first)
        exit 1 if plan.nil?
      else # >1
        Battlestation.ui.error "You cannot have both Battlestation and Battlestation.rb files. Choose one, remove the other."
        exit 1
      end

      # Execute tasks in order
      plan.tasks.each_pair do |name, task|
        Battlestation.ui.group task.title do
          # Show a notice for empty tasks
          if task.operations.empty?
            Battlestation.ui.notice("Nothing defined for #{task.name}")
          end

          task.execute
        end
      end
    end
  end
end
