# frozen_string_literal: true

require "refinements/pathnames"

module SublimeTextKit
  module Metadata
    # Handles the creation, deletion, and recreation of metadata.
    class Handler
      using Refinements::Pathnames

      def self.with_project project_dir, metadata_dir
        new "sublime-project",
            serializer: Serializers::Project.new(
              Pathway[project_dir: project_dir, metadata_dir: metadata_dir]
            )
      end

      def self.with_workspace project_dir, metadata_dir
        new "sublime-workspace",
            serializer: Serializers::Workspace.new(
              Pathway[project_dir: project_dir, metadata_dir: metadata_dir]
            )
      end

      def initialize extension, serializer:
        @extension = extension
        @serializer = serializer
      end

      def create = path.exist? ? path : path.write(JSON.dump(serializer.to_h))

      def delete = path.exist? ? path.delete : path

      def recreate = delete && create

      private

      attr_reader :extension, :serializer

      def path = serializer.pathway.metadata_file(extension)
    end
  end
end
