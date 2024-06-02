# frozen_string_literal: true

require "refinements/pathname"
require "sod"

module SublimeTextKit
  module CLI
    module Actions
      module Metadata
        # Deletes project metadata.
        class Delete < Sod::Action
          include Import[:settings, :logger]

          using Refinements::Pathname

          description "Delete metadata."

          on %w[-d --delete]

          def initialize(handler: SublimeTextKit::Metadata::Handler, **)
            super(**)
            @handler = handler
          end

          def call(*)
            logger.info "Deleting metadata in #{metadata_dir}..."
            process_projects
            logger.info "Metadata deleted."
          end

          private

          attr_reader :handler

          def process_projects
            settings.project_dirs.each do |directory|
              handler.with_project(directory, metadata_dir).delete
              handler.with_workspace(directory, metadata_dir).delete
            end
          end

          def metadata_dir = Pathname(settings.metadata_dir).expand_path
        end
      end
    end
  end
end
