# frozen_string_literal: true

require "optparse"

module SublimeTextKit
  module CLI
    # Assembles and parses all Command Line Interface (CLI) options.
    class Parser
      include Import[:configuration]

      CLIENT = OptionParser.new nil, 40, "  "

      def initialize section: Parsers::Core,
                     client: CLIENT,
                     **dependencies
        super(**dependencies)
        @section = section
        @client = client
        @configuration_duplicate = configuration.dup
      end

      def call arguments = []
        section.call(configuration_duplicate, client:)
        client.parse arguments
        configuration_duplicate.freeze
      end

      def to_s = client.to_s

      private

      attr_reader :section, :client, :configuration_duplicate
    end
  end
end
