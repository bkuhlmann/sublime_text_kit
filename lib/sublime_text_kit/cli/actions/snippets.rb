# frozen_string_literal: true

module SublimeTextKit
  module CLI
    module Actions
      # Handles snippets action.
      class Snippets
        include SublimeTextKit::Import[:configuration, :logger]

        def initialize(printer: SublimeTextKit::Snippets::Printer.new, **)
          super(**)
          @printer = printer
        end

        def call kind
          case kind
            when :ascii_doc then printer.call "*"
            when :markdown then printer.call "-"
            else logger.error { "Invalid snippet format: #{kind}. Use ascii_doc or markdown." }
          end
        end

        private

        attr_reader :printer
      end
    end
  end
end
