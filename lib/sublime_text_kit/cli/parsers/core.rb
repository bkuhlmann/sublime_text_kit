# frozen_string_literal: true

require "versionaire/extensions/option_parser"

module SublimeTextKit
  module CLI
    module Parsers
      # Handles parsing of Command Line Interface (CLI) core options.
      class Core
        def self.call(...) = new(...).call

        def initialize client: CLIENT, container: Container
          @client = client
          @container = container
        end

        def call arguments = []
          client.banner = "#{Identity::LABEL} - #{Identity::SUMMARY}"
          client.separator "\nUSAGE:\n"
          collate
          arguments.empty? ? arguments : client.parse!(arguments)
        end

        private

        attr_reader :client, :container

        def collate = private_methods.sort.grep(/add_/).each { |method| __send__ method }

        def add_config
          client.on(
            "-c",
            "--config ACTION",
            %i[edit view],
            "Manage gem configuration. Actions: edit or view."
          ) do |action|
            configuration.action_config = action
          end
        end

        def add_metadata
          client.on(
            "-m",
            "--metadata ACTION",
            %i[create delete recreate],
            "Manage project metadata. Actions: create, delete, or recreate."
          ) do |action|
            configuration.action_metadata = action
          end
        end

        def add_session
          client.on "-S", "--session", "Rebuild session metadata." do
            configuration.action_session = true
          end
        end

        def add_snippets
          client.on(
            "-s",
            "--snippets [FORMAT]",
            %i[markdown ascii_doc],
            "View snippets. Default: #{configuration.snippets_format}. " \
            "Formats: markdown or ascii_doc."
          ) do |kind|
            configuration.action_snippets = true
            configuration.snippets_format = kind if kind
          end
        end

        def add_update
          client.on(
            "-u",
            "--update",
            "Update project and session metadata based on current settings."
          ) do
            configuration.action_update = true
          end
        end

        def add_version
          client.on "-v", "--version", "Show gem version." do
            configuration.action_version = Identity::VERSION_LABEL
          end
        end

        def add_help
          client.on "-h", "--help", "Show this message." do
            configuration.action_help = true
          end
        end

        private_methods

        def configuration = container[__method__]
      end
    end
  end
end
