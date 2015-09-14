module SublimeTextKit
  module Identity
    def self.name
      "sublime_text_kit"
    end

    def self.label
      "Sublime Text Kit"
    end

    def self.version
      "3.1.0"
    end

    def self.version_label
      [label, version].join " "
    end

    def self.file_name
      ".#{name}rc"
    end
  end
end
