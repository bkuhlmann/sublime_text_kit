# frozen_string_literal: true

require "optparse"

module SublimeTextKit
  module CLI
    # Assembles and parses all Command Line Interface (CLI) options.
    class Parser
      CLIENT = OptionParser.new nil, 40, "  "

      def initialize configuration = Container[:configuration],
                     section: Parsers::Core,
                     client: CLIENT
        @configuration = configuration.dup
        @section = section
        @client = client
      end

      def call arguments = []
        section.call configuration, client: client
        client.parse arguments
        configuration.freeze
      end

      def to_s = client.to_s

      private

      attr_reader :configuration, :section, :client
    end
  end
end
