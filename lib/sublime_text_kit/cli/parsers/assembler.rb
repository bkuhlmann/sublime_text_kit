# frozen_string_literal: true

require "runcom"

module SublimeTextKit
  module CLI
    module Parsers
      # Assembles and parses all Command Line Interface (CLI) options.
      class Assembler
        def initialize section: Core, client: CLIENT, container: Container
          @section = section
          @client = client
          @container = container
        end

        def call arguments = []
          section.call client: client
          client.parse! arguments
          configuration
        end

        def to_s = client.to_s

        private

        attr_reader :section, :client, :container

        def configuration = container[__method__]
      end
    end
  end
end
