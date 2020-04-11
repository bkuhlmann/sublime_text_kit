# frozen_string_literal: true

module SublimeTextKit
  module Snippets
    module Printers
      class Markdown
        def initialize collector: Collector.new
          @collector = collector
        end

        def call
          collector.call.each do |snippet|
            puts "- #{snippet.description} - `#{snippet.trigger}`\n"
          end
        end

        private

        attr_reader :collector
      end
    end
  end
end
