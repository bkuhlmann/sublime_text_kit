# frozen_string_literal: true

module SublimeTextKit
  module CLI
    module Actions
      # Handles snippets action.
      class Snippets
        include SublimeTextKit::Import[:configuration, :logger]

        PRINTERS = {
          ascii_doc: SublimeTextKit::Snippets::Printers::ASCIIDoc.new,
          markdown: SublimeTextKit::Snippets::Printers::Markdown.new
        }.freeze

        def initialize printers: PRINTERS, **dependencies
          super(**dependencies)

          @printers = printers
        end

        def call kind
          printers.fetch(kind).call
        rescue KeyError
          logger.error { "Invalid snippet format: #{kind}. Use #{formats}." }
        end

        private

        attr_reader :printers

        def formats = printers.keys.join(" or ")
      end
    end
  end
end
