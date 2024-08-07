# frozen_string_literal: true

require "refinements/pathname"

module SublimeTextKit
  module Configuration
    # Models the settings.
    Model = Struct.new :project_roots, :metadata_dir, :snippets_format, :session_path, :user_dir do
      using Refinements::Pathname

      def project_dirs
        Array(project_roots).map { |path| Pathname(path).expand_path }
                            .flat_map(&:directories)
      end
    end
  end
end
