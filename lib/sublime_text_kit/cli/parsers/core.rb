# frozen_string_literal: true

require "refinements/structs"

module SublimeTextKit
  module CLI
    module Parsers
      # Handles parsing of Command Line Interface (CLI) core options.
      class Core
        using Refinements::Structs

        def self.call(...) = new(...).call

        def initialize configuration = Container[:configuration],
                       client: Parser::CLIENT,
                       container: Container
          @configuration = configuration
          @client = client
          @container = container
        end

        def call arguments = []
          client.banner = "Sublime Text Kit - #{specification.summary}"
          client.separator "\nUSAGE:\n"
          collate
          client.parse arguments
          configuration
        end

        private

        attr_reader :configuration, :client, :container

        def collate = private_methods.sort.grep(/add_/).each { |method| __send__ method }

        def add_config
          client.on(
            "-c",
            "--config ACTION",
            %i[edit view],
            "Manage gem configuration. Actions: edit or view."
          ) do |action|
            configuration.merge! action_config: action
          end
        end

        def add_metadata
          client.on(
            "-m",
            "--metadata ACTION",
            %i[create delete recreate],
            "Manage project metadata. Actions: create, delete, or recreate."
          ) do |action|
            configuration.merge! action_metadata: action
          end
        end

        def add_session
          client.on "-S", "--session", "Rebuild session metadata." do
            configuration.merge! action_session: true
          end
        end

        def add_snippets
          client.on(
            "-s",
            "--snippets [FORMAT]",
            %i[markdown ascii_doc],
            "View snippets. Formats: markdown or ascii_doc. " \
            "Default: #{configuration.snippets_format}."
          ) do |kind|
            configuration.merge! action_snippets: true, snippets_format: kind
          end
        end

        def add_update
          client.on(
            "-u",
            "--update",
            "Update project and session metadata based on current settings."
          ) do
            configuration.merge! action_update: true
          end
        end

        def add_version
          client.on "-v", "--version", "Show gem version." do
            configuration.merge! action_version: true
          end
        end

        def add_help
          client.on "-h", "--help", "Show this message." do
            configuration.merge! action_help: true
          end
        end

        def specification = container[__method__]
      end
    end
  end
end
