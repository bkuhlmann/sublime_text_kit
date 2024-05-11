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

        def call attributes
          return Success attributes unless attributes.key? :home

          Pathname(attributes[:home]).join(default)
                                     .then { |value| Success attributes.merge!(key => value) }
        end

        private

        attr_reader :key, :default
      end
    end
  end
end
