# frozen_string_literal: true

module SublimeTextKit
  module CLI
    module Actions
      # Handles session action.
      class Session
        def initialize rebuilder: Sessions::Rebuilder.new, container: Container
          @rebuilder = rebuilder
          @container = container
        end

        def call
          rebuilder.call
          logger.info "Session rebuilt."
        end

        private

        attr_reader :rebuilder, :container

        def logger = container[__method__]
      end
    end
  end
end
