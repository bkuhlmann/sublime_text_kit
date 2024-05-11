# frozen_string_literal: true

require "dry/monads"

module SublimeTextKit
  module Configuration
    module Transformers
      # Transforms user directory into fully qualified path based on home directory.
      class UserDir
        include Dry::Monads[:result]

        DEFAULT = "Library/Application Support/Sublime Text/Packages/User"

        def initialize key = :user_dir, default: DEFAULT
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
