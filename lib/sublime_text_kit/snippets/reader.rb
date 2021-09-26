# frozen_string_literal: true

require "rexml/document"

module SublimeTextKit
  module Snippets
    # Reads snippet and loads record into memory.
    class Reader
      def initialize model: Model, document: REXML::Document
        @model = model
        @document = document
      end

      def call(path) = path.exist? ? model.for(document.new(path.read)) : model.new

      private

      attr_reader :model, :document
    end
  end
end
