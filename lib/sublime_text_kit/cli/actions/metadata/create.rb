# frozen_string_literal: true

require "refinements/pathname"
require "sod"

module SublimeTextKit
  module CLI
    module Actions
      module Metadata
        # Creates project metadata.
        class Create < Sod::Action
          include Import[:configuration, :logger]

          using Refinements::Pathname

          description "Create metadata."

          on %w[-c --create]

          def initialize(handler: SublimeTextKit::Metadata::Handler, **)
            super(**)
            @handler = handler
          end

          def call(*)
            logger.info "Creating metadata in #{metadata_dir}..."
            process_projects
            logger.info "Metadata created."
          end

          private

          attr_reader :handler

          def process_projects
            configuration.project_dirs.each do |directory|
              handler.with_project(directory, metadata_dir).create
              handler.with_workspace(directory, metadata_dir).create
            end
          end

          def metadata_dir = Pathname(configuration.metadata_dir).expand_path
        end
      end
    end
  end
end
