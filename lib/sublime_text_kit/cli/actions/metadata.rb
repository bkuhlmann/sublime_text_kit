# frozen_string_literal: true

require "refinements/pathnames"

module SublimeTextKit
  module CLI
    module Actions
      # Handles metadata action.
      class Metadata
        using Refinements::Pathnames

        def initialize handler: SublimeTextKit::Metadata::Handler, container: Container
          @handler = handler
          @container = container
        end

        def call kind
          case kind
            when :create then create
            when :delete then delete
            when :recreate then recreate
            else logger.error { "Unknown metadata action: #{kind}." }
          end
        end

        private

        attr_reader :handler, :container

        def create
          logger.info "Creating metadata in #{metadata_dir}..."
          process_projects __method__
          logger.info "Metadata created."
        end

        def delete
          logger.info "Deleting metadata in #{metadata_dir}..."
          process_projects __method__
          logger.info "Metadata deleted."
        end

        def recreate
          logger.info "Recreating metadata in #{metadata_dir}..."
          process_projects __method__
          logger.info "Metadata recreated."
        end

        def process_projects method
          configuration.project_dirs.each do |directory|
            handler.with_project(directory, metadata_dir).public_send method
            handler.with_workspace(directory, metadata_dir).public_send method
          end
        end

        def metadata_dir = Pathname(configuration.metadata_dir).expand_path

        def configuration = container[__method__]

        def logger = container[__method__]
      end
    end
  end
end
