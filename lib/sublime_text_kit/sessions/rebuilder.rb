# frozen_string_literal: true

require "json"
require "refinements/pathnames"

module SublimeTextKit
  module Sessions
    # Manages the rebuilding of session information.
    class Rebuilder
      using Refinements::Pathnames

      def initialize container: Container
        @container = container
      end

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

      attr_reader :container

      def read = source_path.exist? ? JSON(source_path.read) : {}

      def write(json) = JSON.dump(json).then { |content| source_path.write content }

      def metadata_dir = configuration.metadata_dir

      def source_path = configuration.session_path

      def configuration = container[__method__]
    end
  end
end
