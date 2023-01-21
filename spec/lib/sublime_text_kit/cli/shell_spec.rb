# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Shell do
  using Refinements::Pathnames
  using Infusible::Stub

  subject(:shell) { described_class.new }

  include_context "with application dependencies"

  before { SublimeTextKit::CLI::Actions::Import.stub configuration:, kernel:, logger: }

  after { SublimeTextKit::CLI::Actions::Import.unstub :configuration, :kernel, :logger }

  describe "#call" do
    let :workspaces do
      {
        "workspaces" => {
          "recent_workspaces" => [
            "#{configuration.metadata_dir}/black.sublime-workspace",
            "#{configuration.metadata_dir}/red.sublime-workspace",
            "#{configuration.metadata_dir}/white.sublime-workspace"
          ]
        }
      }
    end

    let :ascii_doc do
      <<~CONTENT
        * Ruby Then (multiple line) - `thenm`
        * Ruby Then (proc) - `thenp`
        * Ruby Then (single line) - `then`
      CONTENT
    end

    let :markdown do
      <<~CONTENT
        - Ruby Then (multiple line) - `thenm`
        - Ruby Then (proc) - `thenp`
        - Ruby Then (single line) - `then`
      CONTENT
    end

    it "edits configuration" do
      shell.call %w[--config edit]
      expect(kernel).to have_received(:system).with(include("EDITOR"))
    end

    it "views configuration" do
      shell.call %w[--config view]
      expect(kernel).to have_received(:system).with(include("cat"))
    end

    it "creates metadata" do
      shell.call %w[--metadata create]
      expect(logger.reread).to eq("Creating metadata in #{temp_dir}...\nMetadata created.\n")
    end

    it "deletes metadata" do
      shell.call %w[--metadata delete]
      expect(logger.reread).to eq("Deleting metadata in #{temp_dir}...\nMetadata deleted.\n")
    end

    it "recreates metadata" do
      shell.call %w[--metadata recreate]
      expect(logger.reread).to eq("Recreating metadata in #{temp_dir}...\nMetadata recreated.\n")
    end

    it "rebuilds session" do
      configuration.metadata_dir = SPEC_ROOT.join "support/fixtures/metadata"
      SPEC_ROOT.join("support/fixtures/Session.sublime_session").copy configuration.session_path
      shell.call %w[--session]

      expect(JSON(configuration.session_path.read)).to eq(workspaces)
    end

    it "prints ASCII Doc snippets" do
      shell.call %w[--snippets ascii_doc]
      expect(logger.reread).to eq(ascii_doc)
    end

    it "prints Markdown snippets" do
      shell.call %w[--snippets markdown]
      expect(logger.reread).to eq(markdown)
    end

    it "updates metadata and session" do
      shell.call %w[--update]

      expect(logger.reread).to eq(
        "Updating metadata and session...\nMetadata and session updated.\n"
      )
    end

    it "prints version" do
      shell.call %w[--version]
      expect(logger.reread).to match(/Sublime Text Kit\s\d+\.\d+\.\d+/)
    end

    it "prints help" do
      shell.call %w[--help]
      expect(logger.reread).to match(/Sublime Text Kit.+USAGE.+/m)
    end

    it "prints usage when no options are given" do
      shell.call
      expect(logger.reread).to match(/Sublime Text Kit.+USAGE.+/m)
    end

    it "prints error with invalid option" do
      shell.call %w[--bogus]
      expect(logger.reread).to match(/invalid option.+bogus/)
    end
  end
end
