# frozen_string_literal: true

require "refinements/pathname"
require "sod"

module SublimeTextKit
  module CLI
    module Actions
      module Metadata
        # Recreates project metadata.
        class Recreate < Sod::Action
          include Dependencies[:settings, :logger]

          using Refinements::Pathname

          description "Recreate metadata."

          on %w[-r --recreate]

          def initialize(handler: SublimeTextKit::Metadata::Handler, **)
            super(**)
            @handler = handler
          end

          def call(*)
            logger.info "Recreating metadata in #{metadata_dir}..."
            process_projects
            logger.info "Metadata recreated."
          end

          private

          attr_reader :handler

          def process_projects
            settings.project_dirs.each do |directory|
              handler.with_project(directory, metadata_dir).recreate
              handler.with_workspace(directory, metadata_dir).recreate
            end
          end

          def metadata_dir = Pathname(settings.metadata_dir).expand_path
        end
      end
    end
  end
end
