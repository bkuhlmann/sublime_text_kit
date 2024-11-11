# frozen_string_literal: true

require "sod"

module SublimeTextKit
  module CLI
    module Actions
      # Handles session action.
      class Session < Sod::Action
        include Dependencies[:logger]

        description "Rebuild session metadata."

        on %w[-S --session]

        def initialize(rebuilder: Sessions::Rebuilder.new, **)
          super(**)
          @rebuilder = rebuilder
        end

        def call(*)
          rebuilder.call
          logger.info "Session rebuilt."
        end

        private

        attr_reader :rebuilder
      end
    end
  end
end
