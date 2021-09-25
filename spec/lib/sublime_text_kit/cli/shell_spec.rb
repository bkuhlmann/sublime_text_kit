# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Shell do
  using Refinements::Pathnames

  subject(:shell) { described_class.new }

  include_context "with application container"

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
      expectation = proc { shell.call %w[--metadata create] }
      message = "Creating metadata in #{temp_dir}...\nMetadata created.\n"

      expect(&expectation).to output(message).to_stdout
    end

    it "deletes metadata" do
      expectation = proc { shell.call %w[--metadata delete] }
      message = "Deleting metadata in #{temp_dir}...\nMetadata deleted.\n"

      expect(&expectation).to output(message).to_stdout
    end

    it "recreates metadata" do
      expectation = proc { shell.call %w[--metadata recreate] }
      message = "Recreating metadata in #{temp_dir}...\nMetadata recreated.\n"

      expect(&expectation).to output(message).to_stdout
    end

    it "rebuilds session" do
      configuration.metadata_dir = Bundler.root.join "spec/support/metadata"
      Bundler.root.join("spec/support/Session.sublime_session").copy configuration.session_path
      shell.call %w[--session]

      expect(JSON(configuration.session_path.read)).to eq(workspaces)
    end

    it "prints ASCII Doc snippets" do
      expectation = proc { shell.call %w[--snippets ascii_doc] }
      expect(&expectation).to output(ascii_doc).to_stdout
    end

    it "prints Markdown snippets" do
      expectation = proc { shell.call %w[--snippets markdown] }
      expect(&expectation).to output(markdown).to_stdout
    end

    it "updates metadata and session" do
      expectation = proc { shell.call %w[--update] }
      message = "Updating metadata and session...\nMetadata and session updated.\n"

      expect(&expectation).to output(message).to_stdout
    end

    it "prints version" do
      result = proc { shell.call %w[--version] }
      expect(&result).to output(/Sublime Text Kit\s\d+\.\d+\.\d+/).to_stdout
    end

    it "prints help" do
      result = proc { shell.call %w[--help] }
      expect(&result).to output(/Sublime Text Kit.+USAGE.+/m).to_stdout
    end

    it "prints usage when no options are given" do
      result = proc { shell.call }
      expect(&result).to output(/Sublime Text Kit.+USAGE.+.+/m).to_stdout
    end

    it "prints error with invalid option" do
      result = proc { shell.call %w[--bogus] }
      expect(&result).to output(/invalid option.+bogus/).to_stdout
    end
  end
end
