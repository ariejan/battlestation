module Battlestation
  module Operations
    class FileExistsCheck < Base
      attr_accessor :filename

      def initialize(filename, opts = {})
        @filename = filename
        @type     = :file
        @name     = "file-#{filename}"
        @opts     = opts
      end

      def status
        if file_exists?
          { status: :okay, msg: "#{filename} found", name: name }
        else
          { status: :fail, msg: "#{filename} not found", resolution: opts[:resolution], name: name }
        end
      end

      private
      def file_exists?
        File.exists?(filename)
      end
    end
  end
end
