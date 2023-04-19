# frozen_string_literal: true

require "sod"

module SublimeTextKit
  module CLI
    # The main Command Line Interface (CLI) object.
    class Shell
      include Import[:defaults_path, :xdg_config, :specification]

      def initialize(context: Sod::Context, dsl: Sod, **)
        super(**)
        @context = context
        @dsl = dsl
      end

      def call(...) = cli.call(...)

      private

      attr_reader :context, :dsl

      def cli
        context = build_context

        dsl.new :sublime_text_kit, banner: specification.banner do
          on(Sod::Prefabs::Commands::Config, context:)

          on "metadata", "Manage project metadata." do
            on Actions::Metadata::Create
            on Actions::Metadata::Delete
            on Actions::Metadata::Recreate
          end

          on Actions::Session
          on Actions::Snippets
          on Actions::Update
          on(Sod::Prefabs::Actions::Version, context:)
          on Sod::Prefabs::Actions::Help, self
        end
      end

      def build_context
        context[defaults_path:, xdg_config:, version_label: specification.labeled_version]
      end
    end
  end
end
