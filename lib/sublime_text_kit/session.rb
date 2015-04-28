require "multi_json"

module SublimeTextKit
  class Session
    attr_reader :workspace_dir

    def self.home_path
      ENV.fetch "HOME"
    end

    def self.session_path
      "#{home_path}/Library/Application Support/Sublime Text 3/Local/Session.sublime_session"
    end

    def initialize options = {}
      @workspace_dir = File.expand_path options.fetch(:workspace_dir)
    end

    def workspaces
      Dir["#{workspace_dir}/*.sublime-workspace"].sort
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
      File.open(self.class.session_path, 'w') { |file| file.write MultiJson.dump(json, pretty: true) }
    end
  end
end
