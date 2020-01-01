# frozen_string_literal: true

require "thor"
require "thor/actions"
require "runcom"

module SublimeTextKit
  # The Command Line Interface (CLI) for the gem.
  class CLI < Thor
    include Thor::Actions

    package_name Identity.version_label

    def self.configuration
      Runcom::Config.new "#{Identity.name}/configuration.yml"
    end

    # Initialize.
    def initialize args = [], options = {}, config = {}
      super args, options, config
      @markdown_printer = Snippets::Printers::Markdown.new
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
    method_option :rebuild,
                  aliases: "-R",
                  desc: "Rebuild session metadata.",
                  type: :boolean,
                  default: false
    def session
      say
      options.rebuild? ? rebuild_session : help("--session")
      say
    end

    desc "-p, [--snippets]", "Print user defined snippets."
    map %w[-p --snippets] => :snippets
    method_option :markdown,
                  aliases: "-m",
                  desc: "Print snippets in Markdown format.",
                  type: :boolean,
                  default: false
    def snippets
      say
      options.markdown? ? markdown_printer.call : help("--snippets")
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
      else help "--metadata"
      end

      say
    end

    desc "-c, [--config]", "Manage gem configuration."
    map %w[-c --config] => :config
    method_option :edit,
                  aliases: "-e",
                  desc: "Edit gem configuration.",
                  type: :boolean,
                  default: false
    method_option :info,
                  aliases: "-i",
                  desc: "Print gem configuration.",
                  type: :boolean,
                  default: false
    def config
      path = self.class.configuration.current

      if options.edit? then `#{ENV["EDITOR"]} #{path}`
      elsif options.info?
        path ? say(path) : say("Configuration doesn't exist.")
      else help :config
      end
    end

    desc "-v, [--version]", "Show gem version."
    map %w[-v --version] => :version
    def version
      say Identity.version_label
    end

    desc "-h, [--help=COMMAND]", "Show this message or get help for a command."
    map %w[-h --help] => :help
    def help task = nil
      say and super
    end

    private

    attr_reader :markdown_printer

    def project_roots
      @project_roots ||= self.class.configuration.to_h.fetch :project_roots, []
    end

    def metadata_dir
      @metadata_dir ||= File.expand_path self.class.configuration.to_h.fetch(:metadata_dir)
    end

    def create_metadata
      say_status :info, "Creating metadata...", :green
      say_status :info, "Metadata Path: #{metadata_dir}", :green
      project_roots.each do |project_root|
        say_status :info, "Processing project root: #{File.expand_path project_root}...", :green
        Metadata::Project.create project_root, metadata_dir
        Metadata::Workspace.create project_root, metadata_dir
      end
      say_status :info, "Metadata created.", :green
    end

    def destroy_metadata
      if yes? "Delete metadata in #{metadata_dir}?"
        say_status :info, "Deleting metadata...", :green
        Metadata::Project.delete metadata_dir
        Metadata::Workspace.delete metadata_dir
        say_status :info, "Metadata deleted.", :green
      else
        say_status :info, "Metadata deletion aborted.", :green
      end
    end

    def rebuild_metadata
      if yes? "Rebuild metadata in #{metadata_dir}?"
        say_status :info, "Deleting metadata...", :green
        Metadata::Project.delete metadata_dir
        Metadata::Workspace.delete metadata_dir

        say_status :info, "Creating metadata...", :green
        project_roots.each do |project_root|
          say_status :info, "Processing project root: #{File.expand_path project_root}...", :green
          Metadata::Project.create project_root, metadata_dir
          Metadata::Workspace.create project_root, metadata_dir
        end

        say_status :info, "Metadata rebuilt.", :green
      else
        say_status :info, "Metadata rebuild aborted.", :green
      end
    end

    def rebuild_session
      say_status :info, "Rebuilding session metadata...", :green
      say_status :info, "Metadata (project/workspace) Path: #{metadata_dir}", :green
      say_status :info, "Session Path: #{Session.session_path}", :green
      session = Session.new metadata_dir
      session.rebuild_recent_workspaces
      say_status :info, "Session metadata rebuilt.", :green
    end
  end
end
