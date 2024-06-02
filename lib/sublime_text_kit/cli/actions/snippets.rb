# frozen_string_literal: true

require "sod"

module SublimeTextKit
  module CLI
    module Actions
      # Handles snippets action.
      class Snippets < Sod::Action
        include Import[:settings, :logger]

        description "View snippets."

        on %w[-s --snippets], argument: "[FORMAT]", allow: %w[markdown ascii_doc]

        default { Container[:settings].snippets_format }

        def initialize(printer: SublimeTextKit::Snippets::Printer.new, **)
          super(**)
          @printer = printer
        end

        def call kind = nil
          kind ||= default

          case kind
            when "ascii_doc" then printer.call "*"
            when "markdown" then printer.call "-"
            else logger.error { "Invalid snippet format: #{kind}. Use ascii_doc or markdown." }
          end
        end

        private

        attr_reader :printer
      end
    end
  end
end
