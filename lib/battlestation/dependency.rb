module Battlestation
  class Dependency
    attr_accessor :name
    attr_accessor :executables, :processes

    def initialize(name, &block)
      @name = name
      @executables, @processes = [], []

      instance_eval &block if block_given?
    end

    def executable(filename, opts = {})
      executables << { filename: filename, opts: opts }
    end

    def process(identifier, opts = {})
      processes << { identifier: identifier, opts: opts }
    end

    # Execute this dependency
    def execute
      [check_executables, check_processes].flatten
    end

    private
    def check_executables
      result = []
      executables.each do |exe|
        filename = exe[:filename]
        opts = exe[:opts]
        name = "executable-#{filename}"

        if executable_exists?(filename)
          result << { status: :okay, msg: "#{filename} found", name: name }
        else
          result << { status: :fail, msg: "#{filename} not found", resolution: opts[:resolution], name: name }
        end
      end

      result.flatten
    end

    private
    def check_processes
      result = []
      processes.each do |process|
        identifier = process[:identifier]
        opts = process[:opts]
        name = "process-#{identifier}"

        if process_running?(identifier)
          result << { status: :okay, msg: "#{identifier} up and running", name: name }
        else
          result << { status: opts[:error] ? :fail : :warn, msg: "#{identifier} not running", resolution: opts[:resolution], name: name }
        end
      end

      result.flatten
    end

    private
    def executable_exists?(filename)
      files = %x(/usr/bin/env which #{filename}).split
      return files.any? && File.executable?(files.first)
    end

    private
    def process_running?(identifier)
      processes = %x(ps aux | grep -i #{identifier} | grep -v grep).split
      return processes.any?
    end
  end
end
