# frozen_string_literal: true

require "dry/monads"

module SublimeTextKit
  module Configuration
    module Transformers
      # Transforms session path into fully qualified path based on home directory.
      class SessionPath
        include Dry::Monads[:result]

        DEFAULT = "Library/Application Support/Sublime Text/Local/Session.sublime_session"

        def initialize key = :session_path, default: DEFAULT
          @key = key
          @default = default
        end

        def call content
          return Success content unless content.key? :home

          Pathname(content[:home]).join(default)
                                  .then { |value| Success content.merge!(key => value) }
        end

        private

        attr_reader :key, :default
      end
    end
  end
end
