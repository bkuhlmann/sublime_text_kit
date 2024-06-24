# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Shell do
  using Refinements::Pathname
  using Refinements::StringIO

  subject(:shell) { described_class.new }

  include_context "with application dependencies"

  before { Sod::Container.stub! logger:, io: }

  after { Sod::Container.restore }

  describe "#call" do
    let :workspaces do
      {
        "workspaces" => {
          "recent_workspaces" => [
            "#{settings.metadata_dir}/black.sublime-workspace",
            "#{settings.metadata_dir}/red.sublime-workspace",
            "#{settings.metadata_dir}/white.sublime-workspace"
          ]
        }
      }
    end

    it "prints configuration usage" do
      shell.call %w[config]
      expect(io.reread).to match(/Manage configuration.+/m)
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
      settings.metadata_dir = SPEC_ROOT.join "support/fixtures/metadata"
      SPEC_ROOT.join("support/fixtures/Session.sublime_session").copy settings.session_path
      shell.call %w[--session]

      expect(JSON(settings.session_path.read)).to eq(workspaces)
    end

    it "prints ASCII Doc snippets" do
      shell.call %w[--snippets ascii_doc]

      expect(io.reread).to eq(<<~CONTENT)
        * Ruby Then (multiple line) - `thenm`
        * Ruby Then (proc) - `thenp`
        * Ruby Then (single line) - `then`
      CONTENT
    end

    it "prints Markdown snippets" do
      shell.call %w[--snippets markdown]

      expect(io.reread).to eq(<<~CONTENT)
        - Ruby Then (multiple line) - `thenm`
        - Ruby Then (proc) - `thenp`
        - Ruby Then (single line) - `then`
      CONTENT
    end

    it "updates metadata and session" do
      shell.call %w[--update]

      expect(logger.reread).to match(
        "🟢.+Updating metadata and session....+\n🟢.+Metadata and session updated."
      )
    end

    it "prints version" do
      shell.call %w[--version]
      expect(io.reread).to match(/Sublime Text Kit\s\d+\.\d+\.\d+/)
    end

    it "prints help" do
      shell.call %w[--help]
      expect(io.reread).to match(/Sublime Text Kit.+USAGE.+/m)
    end
  end
end
