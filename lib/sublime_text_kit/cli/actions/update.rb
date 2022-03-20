# frozen_string_literal: true

module SublimeTextKit
  module CLI
    module Actions
      # Handles update action.
      class Update
        include SublimeTextKit::Import[:configuration, :logger]

        def initialize metadata: SublimeTextKit::Metadata::Handler,
                       session: Sessions::Rebuilder.new,
                       **dependencies

          super(**dependencies)

          @metadata = metadata
          @session = session
        end

        def call
          logger.info "Updating metadata and session..."
          create_metadata
          session.call
          logger.info { "Metadata and session updated." }
        end

        private

        attr_reader :metadata, :session

        def create_metadata
          configuration.project_dirs.each do |directory|
            metadata.with_project(directory, metadata_dir).create
            metadata.with_workspace(directory, metadata_dir).create
          end
        end

        def metadata_dir = Pathname(configuration.metadata_dir).expand_path
      end
    end
  end
end
