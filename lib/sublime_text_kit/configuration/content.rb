# frozen_string_literal: true

require "refinements/pathnames"

module SublimeTextKit
  module Configuration
    # Defines configuration content as the primary source of truth for use throughout the gem.
    Content = Struct.new(
      :project_roots,
      :metadata_dir,
      :snippets_format,
      :session_path,
      :user_dir,
      keyword_init: true
    ) do
      using Refinements::Pathnames

      def initialize(**)
        super
        freeze
      end

      def project_dirs
        Array(project_roots).map { |path| Pathname(path).expand_path }
                            .flat_map(&:directories)
      end
    end
  end
end
