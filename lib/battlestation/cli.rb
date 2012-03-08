module Battlestation
  class CLI < Thor
    include Thor::Actions

    def initialize(*)
      super

      the_shell = (options["no-color"] ? Thor::Shell::Basic.new : shell)
      Battlestation.ui = UI::Shell.new(the_shell)

      Battlestation.ui.info("Manning battlestation...")
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

      if !File.exists?("Battlestation")
        Battlestation.ui.error "Could not read your Battlestation file"
        exit 1
      end

      # Parse/evaluate Battlestation
      plan = eval(File.read("Battlestation"))

      results = plan.execute

      # Report successes and failures
      results.each do |result|
        Battlestation.ui.send(result[:status], result[:msg])
      end

      # Report resolutions
      resolutions = results.map { |result| result[:resolution] }.compact
      if resolutions.any?
        Battlestation.ui.info("\nResolutions:\n")
        resolutions.each { |resolution| Battlestation.ui.info(" * #{resolution}") }
      end
    end
  end
end
