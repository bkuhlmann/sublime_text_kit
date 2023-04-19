# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Configuration::Content do
  using Refinements::Structs

  subject(:content) { described_class.new }

  describe "#initialize" do
    let :proof do
      {
        project_roots: nil,
        metadata_dir: nil,
        snippets_format: nil,
        session_path: Pathname(Dir.home).join(
          "Library/Application Support/Sublime Text/Local/Session.sublime_session"
        ),
        user_dir: Pathname(Dir.home).join(
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
        SPEC_ROOT.join("support/fixtures/projects/black"),
        SPEC_ROOT.join("support/fixtures/projects/red"),
        SPEC_ROOT.join("support/fixtures/projects/white"),
        SPEC_ROOT.join("support/fixtures/projects/black"),
        SPEC_ROOT.join("support/fixtures/projects/red"),
        SPEC_ROOT.join("support/fixtures/projects/white")
      ]
    end

    it "answers empty array when project directories don't exist" do
      expect(content.project_dirs).to eq([])
    end

    it "answers project directories when single project root exists" do
      updated_content = content.merge project_roots: SPEC_ROOT.join("support/fixtures/projects")

      expect(updated_content.project_dirs).to contain_exactly(
        SPEC_ROOT.join("support/fixtures/projects/black"),
        SPEC_ROOT.join("support/fixtures/projects/red"),
        SPEC_ROOT.join("support/fixtures/projects/white")
      )
    end

    it "answers project directories when multiple project roots exists" do
      updated_content = content.merge project_roots: [
        SPEC_ROOT.join("support/fixtures/projects"),
        SPEC_ROOT.join("support/fixtures/projects").to_s
      ]

      expect(updated_content.project_dirs).to match_array(proof)
    end
  end
end
