require "oj"

module SublimeTextKit
  class Session
    attr_accessor :workspaces_path

    def self.home_path
      ENV["HOME"]
    end

    def self.session_path
      "#{home_path}/Library/Application Support/Sublime Text 2/Settings/Session.sublime_session"
    end

    def initialize workspaces_path: ''
      @workspaces_path = workspaces_path
    end

    def workspaces
      Dir["#{workspaces_path}/*.sublime-project"].sort
    end

    def rebuild_recent_workspaces
      session = load_session

      if session && session["workspaces"] && session["workspaces"]["recent_workspaces"]
        session["workspaces"]["recent_workspaces"] = workspaces
        save_session session
      end
    end

    private

    def load_session
      File.exists?(self.class.session_path) ? Oj.load(File.read(self.class.session_path)) : {}
    end

    def save_session json
      File.open(self.class.session_path, 'w') { |file| file.write Oj.dump(json) }
    end
  end
end