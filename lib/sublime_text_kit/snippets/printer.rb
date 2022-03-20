# frozen_string_literal: true

module SublimeTextKit
  module Snippets
    # Prints snippets as a list.
    class Printer
      include Import[:logger]

      def initialize collector: Collector.new, **dependencies
        super(**dependencies)
        @collector = collector
      end

      def call bullet
        collector.call.each do |snippet|
          logger.info "#{bullet} #{snippet.description} - `#{snippet.trigger}`"
        end
      end

      private

      attr_reader :collector
    end
  end
end
