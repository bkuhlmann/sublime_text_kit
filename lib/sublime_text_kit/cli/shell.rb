# frozen_string_literal: true

module SublimeTextKit
  module CLI
    # The main Command Line Interface (CLI) object.
    class Shell
      ACTIONS = {
        config: Actions::Config.new,
        metadata: Actions::Metadata.new,
        session: Actions::Session.new,
        snippets: Actions::Snippets.new,
        update: Actions::Update.new
      }.freeze

      def initialize parser: Parser.new, actions: ACTIONS, container: Container
        @parser = parser
        @actions = actions
        @container = container
      end

      def call arguments = []
        perform parser.call(arguments)
      rescue OptionParser::ParseError, Error => error
        logger.error { error.message }
      end

      private

      attr_reader :parser, :actions, :container

      def perform configuration
        case configuration
          in action_config: Symbol => action then config action
          in action_metadata: Symbol => kind then metadata kind
          in action_session: true then session
          in action_snippets: true then snippets configuration
          in action_update: true then update
          in action_version: true then logger.info { specification.labeled_version }
          else usage
        end
      end

      def config(action) = actions.fetch(__method__).call(action)

      def metadata(kind) = actions.fetch(__method__).call(kind)

      def session = actions.fetch(__method__).call

      def snippets(configuration) = actions.fetch(__method__).call(configuration.snippets_format)

      def update = actions.fetch(__method__).call

      def usage = logger.unknown { parser.to_s }

      def specification = container[__method__]

      def logger = container[__method__]
    end
  end
end
