# frozen_string_literal: true

require "refinements/pathname"

module SublimeTextKit
  module Snippets
    # Collects and loads all snippets into memory for further processing.
    class Collector
      include Dependencies[:settings]

      using Refinements::Pathname

      def initialize(reader: Reader.new, **)
        super(**)
        @reader = reader
      end

      def call
        settings.user_dir
                .files("*.sublime-snippet")
                .map { |path| reader.call path }
                .sort_by(&:description)
      end

      private

      attr_reader :reader
    end
  end
end
