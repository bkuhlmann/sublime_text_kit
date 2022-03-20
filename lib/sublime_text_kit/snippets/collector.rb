# frozen_string_literal: true

require "refinements/pathnames"

module SublimeTextKit
  module Snippets
    # Collects and loads all snippets into memory for further processing.
    class Collector
      include Import[:configuration]

      using Refinements::Pathnames

      def initialize reader: Reader.new, **dependencies
        super(**dependencies)
        @reader = reader
      end

      def call
        configuration.user_dir
                     .files("*.sublime-snippet")
                     .map { |path| reader.call path }
                     .sort_by(&:description)
      end

      private

      attr_reader :reader
    end
  end
end
