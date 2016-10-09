# frozen_string_literal: true

require "json"

module SublimeTextKit
  # Manages Sublime Text session data.
  class Session
    attr_reader :metadata_dir

    def self.home_path
      ENV.fetch "HOME"
    end

    def self.session_path
      "#{home_path}/Library/Application Support/Sublime Text 3/Local/Session.sublime_session"
    end

    def initialize metadata_directory
      @metadata_dir = File.expand_path metadata_directory
    end

    def workspaces
      Dir["#{metadata_dir}/*.sublime-workspace"].sort
    end

    def rebuild_recent_workspaces
      session = load_session
      return unless session && session["workspaces"] && session["workspaces"]["recent_workspaces"]

      session["workspaces"]["recent_workspaces"] = workspaces
      save_session session
    end

    private

    def load_session
      File.exist?(self.class.session_path) ? JSON.parse(File.read(self.class.session_path)) : {}
    end

    def save_session json
      File.open(self.class.session_path, "w") { |file| file.write JSON.dump(json) }
    end
  end
end
