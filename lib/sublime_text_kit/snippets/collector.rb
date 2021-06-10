# frozen_string_literal: true

require "pathname"
require "rexml/document"

module SublimeTextKit
  module Snippets
    class Collector
      DEFAULT_USER_PATH = "Library/Application Support/Sublime Text/Packages/User"

      def initialize model: Snippet, user_path: DEFAULT_USER_PATH, environment: ENV
        @model = model
        @user_path = user_path
        @environment = environment
      end

      def home_path
        Pathname environment.fetch("HOME")
      end

      def root_path
        home_path.join user_path
      end

      def call
        root_path.glob("*.sublime-snippet")
                 .map { |path| model.new REXML::Document.new(path.read) }
                 .sort_by(&:description)
      end

      private

      attr_reader :model, :user_path, :environment
    end
  end
end
