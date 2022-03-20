# frozen_string_literal: true

module SublimeTextKit
  module Snippets
    module Printers
      # Prints snippets in Markdown format.
      class Markdown
        include Import[:logger]

        def initialize collector: Collector.new, **dependencies
          super(**dependencies)
          @collector = collector
        end

        def call
          collector.call.each do |snippet|
            logger.info "- #{snippet.description} - `#{snippet.trigger}`"
          end
        end

        private

        attr_reader :collector
      end
    end
  end
end
