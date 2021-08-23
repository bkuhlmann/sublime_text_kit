# frozen_string_literal: true

module SublimeTextKit
  module Metadata
    # Processes project metadata.
    class Project < Base
      def file_extension
        "sublime-project"
      end

      def to_h
        {
          folders: [
            {path: project_dir}
          ]
        }
      end
    end
  end
end
