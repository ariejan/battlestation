require 'pathname'

module Spec
  module Path
    def root
      @root ||= Pathname.new(File.expand_path("../../..", __FILE__))
    end

    def tmp(*path)
      root.join("tmp", *path)
    end

    def app(*path)
      root = tmp.join("spec_app")
      FileUtils.mkdir_p(root)
      root.join(*path)
    end
  end
end
