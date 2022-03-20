# frozen_string_literal: true

module SublimeTextKit
  module CLI
    # The main Command Line Interface (CLI) object.
    class Shell
      include Actions::Import[
        :specification,
        :logger,
        :config,
        :metadata,
        :session,
        :snippets,
        :update
      ]

      def initialize parser: Parser.new, **dependencies
        super(**dependencies)
        @parser = parser
      end

      def call arguments = []
        perform parser.call(arguments)
      rescue OptionParser::ParseError, Error => error
        logger.error { error.message }
      end

      private

      attr_reader :parser

      def perform configuration
        case configuration
          in action_config: Symbol => action then config.call action
          in action_metadata: Symbol => kind then metadata.call kind
          in action_session: true then session.call
          in action_snippets: true then snippets.call configuration.snippets_format
          in action_update: true then update.call
          in action_version: true then logger.info { specification.labeled_version }
          else usage
        end
      end

      def usage = logger.unknown { parser.to_s }
    end
  end
end
