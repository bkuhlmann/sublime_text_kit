# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Shell do
  using Refinements::Pathname

  subject(:shell) { described_class.new }

  include_context "with application dependencies"

  before { Sod::Container.stub! kernel:, logger: }

  after { Sod::Container.restore }

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

    it "prints configuration usage" do
      shell.call %w[config]
      expect(kernel).to have_received(:puts).with(/Manage configuration.+/m)
    end

    it "creates metadata" do
      shell.call %w[metadata --create]

      expect(logger.reread).to match(
        "🟢.+Creating metadata in #{temp_dir}....+\n🟢.+Metadata created."
      )
    end

    it "deletes metadata" do
      shell.call %w[metadata --delete]

      expect(logger.reread).to match(
        "🟢.+Deleting metadata in #{temp_dir}....+\n🟢.+Metadata deleted."
      )
    end

    it "recreates metadata" do
      shell.call %w[metadata --recreate]

      expect(logger.reread).to match(
        "🟢.+Recreating metadata in #{temp_dir}....+\n🟢.+Metadata recreated."
      )
    end

    it "rebuilds session" do
      configuration.metadata_dir = SPEC_ROOT.join "support/fixtures/metadata"
      SPEC_ROOT.join("support/fixtures/Session.sublime_session").copy configuration.session_path
      shell.call %w[--session]

      expect(JSON(configuration.session_path.read)).to eq(workspaces)
    end

    it "prints ASCII Doc snippets" do
      shell.call %w[--snippets ascii_doc]
      expect(kernel).to have_received(:puts).with("* Ruby Then (multiple line) - `thenm`")
    end

    it "prints Markdown snippets" do
      shell.call %w[--snippets markdown]
      expect(kernel).to have_received(:puts).with("- Ruby Then (multiple line) - `thenm`")
    end

    it "updates metadata and session" do
      shell.call %w[--update]

      expect(logger.reread).to match(
        "🟢.+Updating metadata and session....+\n🟢.+Metadata and session updated."
      )
    end

    it "prints version" do
      shell.call %w[--version]
      expect(kernel).to have_received(:puts).with(/Sublime Text Kit\s\d+\.\d+\.\d+/)
    end

    it "prints help" do
      shell.call %w[--help]
      expect(kernel).to have_received(:puts).with(/Sublime Text Kit.+USAGE.+/m)
    end
  end
end
