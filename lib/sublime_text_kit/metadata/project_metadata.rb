module SublimeTextKit
  module Metadata
    class Project < Base
      def initialize project_dir, metadata_dir
        super project_dir, metadata_dir
      end

      def file_extension
        "sublime-project"
      end

      def to_h
        {
          folders: [
            {path: "#{project_dir}"}
          ]
        }
      end
    end
  end
end
