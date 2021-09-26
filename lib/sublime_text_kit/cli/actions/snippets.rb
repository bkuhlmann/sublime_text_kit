# frozen_string_literal: true

module SublimeTextKit
  module CLI
    module Actions
      # Handles snippets action.
      class Snippets
        PRINTERS = {
          ascii_doc: SublimeTextKit::Snippets::Printers::ASCIIDoc.new,
          markdown: SublimeTextKit::Snippets::Printers::Markdown.new
        }.freeze

        def initialize printers: PRINTERS, container: Container
          @printers = printers
          @container = container
        end

        def call
          kind = configuration.snippets_format
          printers.fetch(kind).call
        rescue KeyError
          logger.error { "Invalid snippet format: #{kind}." }
        end

        private

        attr_reader :printers, :container

        def configuration = container[__method__]

        def logger = container[__method__]
      end
    end
  end
end
