# frozen_string_literal: true

require "dry/container"

module SublimeTextKit
  module CLI
    module Actions
      # Provides a single container with application and action specific dependencies.
      module Container
        extend Dry::Container::Mixin

        config.registry = ->(container, key, value, _options) { container[key.to_s] = value }

        merge SublimeTextKit::Container

        register(:config) { Actions::Config.new }
        register(:metadata) { Actions::Metadata.new }
        register(:session) { Actions::Session.new }
        register(:snippets) { Actions::Snippets.new }
        register(:update) { Actions::Update.new }
      end
    end
  end
end
