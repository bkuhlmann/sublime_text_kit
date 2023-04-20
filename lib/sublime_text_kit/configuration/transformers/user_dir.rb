# frozen_string_literal: true

require "dry/monads"

module SublimeTextKit
  module Configuration
    module Transformers
      # Transforms user directory into fully qualified path based on home directory.
      class UserDir
        include Dry::Monads[:result]

        def initialize path = "Library/Application Support/Sublime Text/Packages/User"
          @path = path
        end

        def call content
          return Success content unless content.key? :home

          Pathname(content[:home]).join(path)
                                  .then { |user_dir| Success content.merge!(user_dir:) }
        end

        private

        attr_reader :path
      end
    end
  end
end
