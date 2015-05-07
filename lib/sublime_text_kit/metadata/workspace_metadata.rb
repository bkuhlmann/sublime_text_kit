module SublimeTextKit
  module Metadata
    class Workspace < Base
      def initialize project_dir, metadata_dir
        super project_dir, metadata_dir
      end

      def file_extension
        "sublime-workspace"
      end

      def to_h
        {
          expanded_folders: ["#{project_dir}"],
          select_project: {
            selected_items: [
              [name, File.join(metadata_dir, "#{name}.sublime-project")]
            ]
          }
        }
      end
    end
  end
end
