# frozen_string_literal: true

require "refinements/pathnames"

module SublimeTextKit
  module Snippets
    # Collects and loads all snippets into memory for further processing.
    class Collector
      using Refinements::Pathnames

      def initialize reader: Reader.new, container: Container
        @reader = reader
        @container = container
      end

      def call
        configuration.user_dir
                     .files("*.sublime-snippet")
                     .map { |path| reader.call path }
                     .sort_by(&:description)
      end

      private

      def configuration = container[__method__]

      attr_reader :reader, :container
    end
  end
end
