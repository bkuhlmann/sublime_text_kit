# frozen_string_literal: true

require "refinements/pathnames"

module SublimeTextKit
  module Configuration
    # Defines configuration content as the primary source of truth for use throughout the gem.
    Content = Struct.new(
      :action_config,
      :action_help,
      :action_metadata,
      :action_session,
      :action_snippets,
      :action_update,
      :action_version,
      :project_roots,
      :metadata_dir,
      :snippets_format,
      :session_path,
      :user_dir,
      keyword_init: true
    ) do
      using Refinements::Pathnames

      def initialize *arguments
        super

        home = Pathname ENV["HOME"]

        self[:session_path] ||= home.join(
          "Library/Application Support/Sublime Text/Local/Session.sublime_session"
        )

        self[:user_dir] ||= home.join "Library/Application Support/Sublime Text/Packages/User"
      end

      def project_dirs
        Array(project_roots).map { |path| Pathname(path).expand_path }
                            .flat_map(&:directories)
      end
    end
  end
end
