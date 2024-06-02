# frozen_string_literal: true

require "json"
require "refinements/pathname"

module SublimeTextKit
  module Sessions
    # Manages the rebuilding of session information.
    class Rebuilder
      include Import[:settings]

      using Refinements::Pathname

      def call
        session = read

        return unless session.dig "workspaces", "recent_workspaces"

        Pathname(metadata_dir).expand_path
                              .files("*.sublime-workspace")
                              .then do |workspaces|
                                session["workspaces"]["recent_workspaces"] = workspaces
                                write session
                              end
      end

      private

      def read = source_path.exist? ? JSON(source_path.read) : {}

      def write(json) = JSON.dump(json).then { |content| source_path.write content }

      def metadata_dir = settings.metadata_dir

      def source_path = settings.session_path
    end
  end
end
