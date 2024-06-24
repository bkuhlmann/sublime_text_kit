# frozen_string_literal: true

module SublimeTextKit
  module Snippets
    # Prints snippets as a list.
    class Printer
      include Import[:io]

      def initialize(collector: Collector.new, **)
        super(**)
        @collector = collector
      end

      def call bullet
        collector.call.each do |snippet|
          io.puts "#{bullet} #{snippet.description} - `#{snippet.trigger}`"
        end
      end

      private

      attr_reader :collector
    end
  end
end
