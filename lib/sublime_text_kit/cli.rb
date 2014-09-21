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
      @settings_file = File.join ENV.fetch("HOME"), ".sublime", "settings.yml"
      @settings = load_yaml @settings_file
    end

    desc "-p, [--project]", "Manage project metadata."
    map %w(-p --project) => :project
    method_option :create, aliases: "-c", desc: "Create project metadata.", type: :boolean, default: false
    method_option :destroy, aliases: "-D", desc: "Destroy all project metadata.", type: :boolean, default: false
    def project
      say

      case
        when options[:create] then create_project_metadata
        when options[:destroy] then destroy_project_metadata
        else help("--project")
      end

      say
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

    def create_project_metadata
      project_roots = @settings.fetch :project_roots, []
      workspaces_path = @settings.fetch :workspaces_path

      info "Creating project metadata..."
      info "Workspaces Path: #{workspaces_path}"
      project_roots.each do |project_root|
        info "Processing project root: #{project_root}..."
        SublimeTextKit::ProjectMetadata.create project_root, workspaces_path
      end
      info "Project metadata created."
    end

    def destroy_project_metadata
      workspaces_path = @settings.fetch :workspaces_path

      if yes? "Delete all project metadata in #{workspaces_path}?"
        info "Deleting project metadata..."
        SublimeTextKit::ProjectMetadata.delete workspaces_path
        info "Project metadata deleted."
      else
        info "Project metadata deletion aborted."
      end
    end

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
