# frozen_string_literal: true

module SublimeTextKit
  module Snippets
    module Printers
      # Prints snippets in ASCII Doc format.
      class ASCIIDoc
        def initialize collector: Collector.new, container: Container
          @collector = collector
          @container = container
        end

        def call
          collector.call.each do |snippet|
            logger.info "* #{snippet.description} - `#{snippet.trigger}`"
          end
        end

        private

        attr_reader :collector, :container

        def logger = container[__method__]
      end
    end
  end
end
