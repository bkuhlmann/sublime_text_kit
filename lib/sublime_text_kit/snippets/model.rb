# frozen_string_literal: true

module SublimeTextKit
  module Snippets
    KEY_MAP = {
      "content" => :content,
      "tabTrigger" => :trigger,
      "description" => :description,
      "scope" => :scope
    }.freeze

    # Defines a snippet record.
    Model = Struct.new(*KEY_MAP.values, keyword_init: true) do
      def self.for document, key_map: KEY_MAP
        root = document.root

        return new unless root

        root.elements
            .reduce({}) { |attributes, element| attributes.merge element.name => element.text }
            .transform_keys(key_map)
            .then { |attributes| new(**attributes) }
      end

      def initialize *arguments
        super
        freeze
      end
    end
  end
end
