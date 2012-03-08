module Battlestation
  class Dependency
    attr_accessor :name
    attr_accessor :executables

    def initialize(name, &block)
      @name = name
      @executables = []

      instance_eval &block if block_given?
    end

    def executable(filename, opts = {})
      executables << { filename: filename, opts: opts }
    end

    # Execute this dependency
    def execute
      result = []

      executables.each do |exe|
        filename = exe[:filename]
        opts = exe[:opts]
        name = "executable-#{filename}"


        if system("/usr/bin/env which #{filename} &> /dev/null")
          result << { status: :okay, msg: "#{filename} found", name: name }
        else
          result << { status: :fail, msg: "#{filename} not found", resolution: opts[:resolution], name: name }
        end
      end

      result.flatten
    end
  end
end
