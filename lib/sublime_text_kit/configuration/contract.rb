# frozen_string_literal: true

require "dry/schema"
require "etcher"

Dry::Schema.load_extensions :monads

module SublimeTextKit
  module Configuration
    Contract = Dry::Schema.Params do
      optional(:project_roots).filled :array
      optional(:metadata_dir).filled Etcher::Types::Pathname
      required(:snippets_format).filled :string
      required(:session_path).filled Etcher::Types::Pathname
      required(:user_dir).filled Etcher::Types::Pathname
    end
  end
end
