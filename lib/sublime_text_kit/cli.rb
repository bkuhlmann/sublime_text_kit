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

    desc "-m, [--metadata]", "Manage project/workspace metadata."
    map %w(-m --metadata) => :metadata
    method_option :create, aliases: "-c", desc: "Create metadata.", type: :boolean, default: false
    method_option :destroy, aliases: "-D", desc: "Destroy metadata.", type: :boolean, default: false
    def metadata
      say

      case
        when options[:create] then create_metadata
        when options[:destroy] then destroy_metadata
        else help("--metadata")
      end

      say
    end

    desc "-s, [--session]", "Manage session metadata."
    map %w(-s --session) => :session
    method_option :rebuild_session, aliases: "-r", desc: "Rebuild session metadata.", type: :boolean, default: false
    def session
      say

      case
        when options[:rebuild_session] then rebuild_session
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

    def metadata_dir
      @metadata_dir ||= File.expand_path @settings.fetch(:metadata_dir)
    end

    def create_metadata
      info "Creating metadata..."
      info "Metadata Path: #{metadata_dir}"
      project_roots.each do |project_root|
        info "Processing project root: #{File.expand_path project_root}..."
        SublimeTextKit::Metadata::Project.create project_root, metadata_dir
        SublimeTextKit::Metadata::Workspace.create project_root, metadata_dir
      end
      info "Metadata created."
    end

    def destroy_metadata
      if yes? "Delete all metadata in #{metadata_dir}?"
        info "Deleting metadata..."
        SublimeTextKit::Metadata::Project.delete metadata_dir
        SublimeTextKit::Metadata::Workspace.delete metadata_dir
        info "Metadata deleted."
      else
        info "Metadata deletion aborted."
      end
    end

    def rebuild_session
      info "Rebuilding session metadata..."
      info "Metadata (project/workspace) Path: #{metadata_dir}"
      info "Session Path: #{SublimeTextKit::Session.session_path}"
      session = SublimeTextKit::Session.new metadata_dir
      session.rebuild_recent_workspaces
      info "Session metadata rebuilt."
    end
  end
end
