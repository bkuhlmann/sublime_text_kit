require "multi_json"

module SublimeTextKit
  class Session
    attr_accessor :workspaces_path

    def self.home_path
      ENV["HOME"]
    end

    def self.session_path
      "#{home_path}/Library/Application Support/Sublime Text 2/Settings/Session.sublime_session"
    end

    def initialize options = {}
      @workspaces_path = options.fetch :workspaces_path, ''
    end

    def workspaces_absolute_path
      File.expand_path workspaces_path
    end

    def workspaces
      Dir["#{workspaces_absolute_path}/*.sublime-project"].sort
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
      File.exists?(self.class.session_path) ? MultiJson.load(File.read(self.class.session_path)) : {}
    end

    def save_session json
      File.open(self.class.session_path, 'w') { |file| file.write MultiJson.dump(json) }
    end
  end
end
