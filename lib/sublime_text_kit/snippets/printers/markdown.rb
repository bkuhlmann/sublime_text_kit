# frozen_string_literal: true

require "rexml/document"

module SublimeTextKit
  module Snippets
    module Printers
      class Markdown
        DEFAULT_USER_PATH = "Library/Application Support/Sublime Text 3/Packages/User"

        def initialize user_path = DEFAULT_USER_PATH, environment: ENV
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
          snippets.sort_by(&:description).each do |snippet|
            puts "- #{snippet.description} - `#{snippet.trigger}`\n"
          end
        end

        private

        attr_reader :user_path, :environment

        def snippets
          root_path.glob("*.sublime-snippet").map do |path|
            Snippet.new REXML::Document.new(File.open(path))
          end
        end
      end
    end
  end
end
