# frozen_string_literal: true

require "dry/monads"

module SublimeTextKit
  module Configuration
    module Transformers
      # Transforms session path into fully qualified path based on home directory.
      class SessionPath
        include Dry::Monads[:result]

        def initialize
          path = "Library/Application Support/Sublime Text/Local/Session.sublime_session"

          @path = path
        end

        def call content
          return Success content unless content.key? :home

          Pathname(content[:home]).join(path)
                                  .then { |session_path| Success content.merge!(session_path:) }
        end

        private

        attr_reader :path
      end
    end
  end
end
