# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Configuration::Content do
  subject(:content) { described_class.new }

  describe "#initialize" do
    let :proof do
      {
        action_config: nil,
        action_help: nil,
        action_metadata: nil,
        action_session: nil,
        action_snippets: nil,
        action_update: nil,
        action_version: nil,
        project_roots: nil,
        metadata_dir: nil,
        snippets_format: nil,
        session_path: Pathname(ENV["HOME"]).join(
          "Library/Application Support/Sublime Text/Local/Session.sublime_session"
        ),
        user_dir: Pathname(ENV["HOME"]).join(
          "Library/Application Support/Sublime Text/Packages/User"
        )
      }
    end

    it "answers default attributes" do
      expect(content).to have_attributes(proof)
    end
  end

  describe "#project_dirs" do
    let :proof do
      [
        Bundler.root.join("spec/support/projects/black"),
        Bundler.root.join("spec/support/projects/red"),
        Bundler.root.join("spec/support/projects/white"),
        Bundler.root.join("spec/support/projects/black"),
        Bundler.root.join("spec/support/projects/red"),
        Bundler.root.join("spec/support/projects/white")
      ]
    end

    it "answers empty array when project directories don't exist" do
      expect(content.project_dirs).to eq([])
    end

    it "answers project directories when single project root exists" do
      content.project_roots = Bundler.root.join "spec/support/projects"

      expect(content.project_dirs).to contain_exactly(
        Bundler.root.join("spec/support/projects/black"),
        Bundler.root.join("spec/support/projects/red"),
        Bundler.root.join("spec/support/projects/white")
      )
    end

    it "answers project directories when multiple project roots exists" do
      content.project_roots = [
        Bundler.root.join("spec/support/projects"),
        Bundler.root.join("spec/support/projects").to_s
      ]

      expect(content.project_dirs).to contain_exactly(*proof)
    end
  end
end