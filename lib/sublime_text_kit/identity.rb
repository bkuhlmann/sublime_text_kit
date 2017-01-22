# frozen_string_literal: true

module SublimeTextKit
  # Gem identity information.
  module Identity
    def self.name
      "sublime_text_kit"
    end

    def self.label
      "Sublime Text Kit"
    end

    def self.version
      "5.0.0"
    end

    def self.version_label
      "#{label} #{version}"
    end

    def self.file_name
      ".#{name}rc"
    end
  end
end
