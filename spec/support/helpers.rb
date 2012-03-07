module Spec
  module Helpers
    def reset!
      @in_p, @out_p, @err_p = nil, nil, nil
    end

    attr_reader :out, :err, :exitstatus

    def battlestation(cmd, options = {})
      expect_err = options.delete(:expect_err)
      exitstatus = options.delete(:exitstatus)
      options["no-color"] = true unless options.key?("no-color")

      battlestation_bin = File.expand_path('../../../bin/battlestation', __FILE__)

      args = options.map do |k,v|
        v == true ? " --#{k}" : " --#{k} #{v}" if v
      end.join

      cmd = "#{Gem.ruby} -I#{lib} #{battlestation_bin} #{cmd}#{args}"

      if exitstatus
        sys_status(cmd)
      else
        sys_exec(cmd, expect_err) { |i| yield i if block_given? }
      end
    end

    def lib
      File.expand_path("../../../lib", __FILE__)
    end

    # Execute a command and get stdout and stderr filled
    def sys_exec(cmd, expect_err = false)
      Open3.popen3(cmd.to_s) do |stdin, stdout, stderr|
        @in_p, @out_p, @err_p = stdin, stdout, stderr

        yield @in_p if block_given?
        @in_p.close

        @out = @out_p.read_available_bytes.strip
        @err = @err_p.read_available_bytes.strip
      end

      puts @err unless expect_err || @err.empty?
      @out
    end

    # Execute a command and retrieve the exitstatus
    def sys_status(cmd)
      @err = nil
      @out = %x{#{cmd}}.strip
      @exitstatus = $?.exitstatus
    end
  end
end
