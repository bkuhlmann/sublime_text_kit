# frozen_string_literal: true

require "yaml"
require "thor"
require "thor/actions"
require "thor_plus/actions"
require "runcom"

module SublimeTextKit
  # The Command Line Interface (CLI) for the gem.
  class CLI < Thor
    include Thor::Actions
    include ThorPlus::Actions

    package_name SublimeTextKit::Identity.version_label

    def self.defaults
      {}
    end

    # Initialize.
    def initialize args = [], options = {}, config = {}
      super args, options, config
      @settings_file = File.join ENV["HOME"], Identity.file_name
      @settings = load_yaml @settings_file
      @configuration = ::Runcom::Configuration.new file_name: Identity.file_name, defaults: self.class.defaults
    end

    desc "-u, [--update]", "Update Sublime Text with current settings."
    map %w[-u --update] => :update
    def update
      create_metadata
      say
      rebuild_session
    end

    desc "-s, [--session]", "Manage session metadata."
    map %w[-s --session] => :session
    method_option :rebuild_session, aliases: "-r", desc: "Rebuild session metadata.", type: :boolean, default: false
    def session
      say
      options[:rebuild_session] ? rebuild_session : help("--session")
      say
    end

    desc "-m, [--metadata]", "Manage project/workspace metadata."
    map %w[-m --metadata] => :metadata
    method_option :create, aliases: "-c", desc: "Create metadata.", type: :boolean, default: false
    method_option :destroy, aliases: "-D", desc: "Destroy metadata.", type: :boolean, default: false
    method_option :rebuild, aliases: "-R", desc: "Rebuild metadata.", type: :boolean, default: false
    def metadata
      say

      if options[:create] then create_metadata
      elsif options[:destroy] then destroy_metadata
      elsif options[:rebuild] then rebuild_metadata
      else help("--metadata")
      end

      say
    end

    desc "-e, [--edit]", "Edit gem settings in default editor."
    map %w[-e --edit] => :edit
    def edit
      `#{editor} #{@settings_file}`
    end

    desc "-c, [--config]", "Manage gem configuration."
    map %w[-c --config] => :config
    method_option :edit, aliases: "-e", desc: "Edit gem configuration.", type: :boolean, default: false
    method_option :info, aliases: "-i", desc: "Print gem configuration info.", type: :boolean, default: false
    def config
      if options.edit? then `#{editor} #{configuration.computed_path}`
      elsif options.info? then say("Using: #{configuration.computed_path}.")
      else help(:config)
      end
    end

    desc "-v, [--version]", "Show gem version."
    map %w[-v --version] => :version
    def version
      say SublimeTextKit::Identity.version_label
    end

    desc "-h, [--help=HELP]", "Show this message or get help for a command."
    map %w[-h --help] => :help
    def help task = nil
      say and super
    end

    private

    attr_reader :configuration

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
      if yes? "Delete metadata in #{metadata_dir}?"
        info "Deleting metadata..."
        SublimeTextKit::Metadata::Project.delete metadata_dir
        SublimeTextKit::Metadata::Workspace.delete metadata_dir
        info "Metadata deleted."
      else
        info "Metadata deletion aborted."
      end
    end

    def rebuild_metadata
      if yes? "Rebuild metadata in #{metadata_dir}?"
        info "Deleting metadata..."
        SublimeTextKit::Metadata::Project.delete metadata_dir
        SublimeTextKit::Metadata::Workspace.delete metadata_dir

        info "Creating metadata..."
        project_roots.each do |project_root|
          info "Processing project root: #{File.expand_path project_root}..."
          SublimeTextKit::Metadata::Project.create project_root, metadata_dir
          SublimeTextKit::Metadata::Workspace.create project_root, metadata_dir
        end

        info "Metadata rebuilt."
      else
        info "Metadata rebuild aborted."
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
