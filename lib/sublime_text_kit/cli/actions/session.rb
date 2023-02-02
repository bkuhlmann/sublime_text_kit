# frozen_string_literal: true

module SublimeTextKit
  module CLI
    module Actions
      # Handles session action.
      class Session
        include SublimeTextKit::Import[:logger]

        def initialize(rebuilder: Sessions::Rebuilder.new, **)
          super(**)
          @rebuilder = rebuilder
        end

        def call
          rebuilder.call
          logger.info "Session rebuilt."
        end

        private

        attr_reader :rebuilder
      end
    end
  end
end
