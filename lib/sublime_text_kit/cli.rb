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

    def project_roots
      @project_roots ||= @settings.fetch :project_roots, []
    end

    def workspace_dir
      @workspace_dir ||= File.expand_path @settings.fetch(:workspace_dir)
    end

    def create_project_metadata
      info "Creating project metadata..."
      info "Workspaces Path: #{workspace_dir}"
      project_roots.each do |project_root|
        info "Processing project root: #{File.expand_path project_root}..."
        SublimeTextKit::ProjectMetadata.create project_root, workspace_dir
      end
      info "Project metadata created."
    end

    def destroy_project_metadata
      if yes? "Delete all project metadata in #{workspace_dir}?"
        info "Deleting project metadata..."
        SublimeTextKit::ProjectMetadata.delete workspace_dir
        info "Project metadata deleted."
      else
        info "Project metadata deletion aborted."
      end
    end

    def rebuild_recent_workspaces
      info "Rebuilding recent workspaces..."
      info "Workspaces Path: #{workspace_dir}"
      info "Sublime Text Session: #{SublimeTextKit::Session.session_path}"
      session = SublimeTextKit::Session.new workspace_dir: workspace_dir
      session.rebuild_recent_workspaces
      info "Recent workspaces rebuilt."
    end
  end
end
