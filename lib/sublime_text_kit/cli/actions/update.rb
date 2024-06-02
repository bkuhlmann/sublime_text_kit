# frozen_string_literal: true

require "sod"

module SublimeTextKit
  module CLI
    module Actions
      # Handles update action.
      class Update < Sod::Action
        include Import[:settings, :logger]

        description "Update project and session metadata based on current settings."

        on %w[-u --update]

        def initialize(
          metadata: SublimeTextKit::Metadata::Handler,
          session: Sessions::Rebuilder.new,
          **
        )
          super(**)
          @metadata = metadata
          @session = session
        end

        def call(*)
          logger.info "Updating metadata and session..."
          create_metadata
          session.call
          logger.info { "Metadata and session updated." }
        end

        private

        attr_reader :metadata, :session

        def create_metadata
          settings.project_dirs.each do |directory|
            metadata.with_project(directory, metadata_dir).create
            metadata.with_workspace(directory, metadata_dir).create
          end
        end

        def metadata_dir = Pathname(settings.metadata_dir).expand_path
      end
    end
  end
end
