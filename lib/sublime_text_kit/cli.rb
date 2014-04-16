require "yaml"
require "thor"
require "thor/actions"
require "thor_plus/actions"

module SublimeTextKit
  class CLI < Thor
  	include Thor::Actions
  	include ThorPlus::Actions

    # Initialize.
    def initialize args = [], options = {}, config = {}
      super args, options, config
      @settings_file = File.join ENV["HOME"], ".sublime", "settings.yml"
      @settings = load_yaml @settings_file
    end

    desc "-s, [--session]", "Manage session data."
    map %w(-s --session) => :session
    method_option :rebuild_recent_workspaces, aliases: "-r", desc: "Rebuild recent workspaces.", type: :boolean, default: false
    def session
      say

      case
      when options[:rebuild_recent_workspaces] then rebuild_recent_workspaces
      else help("--session")
      end

      say
    end

    desc "-e, [--edit]", "Edit settings in default editor (assumes $EDITOR environment variable)."
    map %w(-e --edit) => :edit
    def edit
      `#{editor} #{@settings_file}`
    end

    desc "-v, [--version]", "Show version."
    map %w(-v --version) => :version
    def version
      say "Sublime Text Kit " + VERSION
    end

    desc "-h, [--help=HELP]", "Show this message or get help for a command."
    map %w(-h --help) => :help
    def help task = nil
      say and super
    end

    private

    def rebuild_recent_workspaces
      info "Rebuilding recent workspaces..."
      session = SublimeTextKit::Session.new workspaces_path: @settings[:workspaces_path]
      info "Workspaces Path: #{session.workspaces_absolute_path}"
      info "Sublime Text Session: #{SublimeTextKit::Session.session_path}"
      session.rebuild_recent_workspaces
      info "Recent workspaces rebuilt."
    end
  end
end
