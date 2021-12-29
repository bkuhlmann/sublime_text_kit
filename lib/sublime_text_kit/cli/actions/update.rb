# frozen_string_literal: true

module SublimeTextKit
  module CLI
    module Actions
      # Handles update action.
      class Update
        def initialize metadata: SublimeTextKit::Metadata::Handler,
                       session: Sessions::Rebuilder.new,
                       container: Container
          @metadata = metadata
          @session = session
          @container = container
        end

        def call
          logger.info "Updating metadata and session..."
          create_metadata
          session.call
          logger.info { "Metadata and session updated." }
        end

        private

        attr_reader :metadata, :session, :container

        def create_metadata
          configuration.project_dirs.each do |directory|
            metadata.with_project(directory, metadata_dir).create
            metadata.with_workspace(directory, metadata_dir).create
          end
        end

        def metadata_dir = Pathname(configuration.metadata_dir).expand_path

        def configuration = container[__method__]

        def logger = container[__method__]
      end
    end
  end
end
