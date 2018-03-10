# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Session do
  subject { described_class.new Bundler.root.join("spec", "support", "metadata") }
  let(:session_file) { Bundler.root.join "spec", "support", "Session.sublime_session" }
  let(:session_backup_file) { Bundler.root.join "spec", "support", "Session.backup" }
  before { allow(described_class).to receive_messages session_path: session_file }

  describe "#metadata_dir" do
    it "answers absolute path" do
      subject = described_class.new "~/tmp"
      expect(subject.metadata_dir).to_not start_with("~")
    end
  end

  describe "#workspaces" do
    it "answers alpha-sorted list of sublime workspace files" do
      project_files = %W[
        #{subject.metadata_dir}/black.sublime-workspace
        #{subject.metadata_dir}/red.sublime-workspace
        #{subject.metadata_dir}/white.sublime-workspace
      ]

      expect(subject.workspaces).to eq(project_files)
    end
  end

  describe "#rebuild_recent_workspaces" do
    it "updates session when workspaces are found" do
      session = {
        "workspaces" => {
          "recent_workspaces" => [
            "#{subject.metadata_dir}/black.sublime-workspace",
            "#{subject.metadata_dir}/red.sublime-workspace",
            "#{subject.metadata_dir}/white.sublime-workspace"
          ]
        }
      }

      subject.rebuild_recent_workspaces
      updated_session = JSON.parse File.read(described_class.session_path)
      FileUtils.cp session_backup_file, session_file

      expect(updated_session).to eq(session)
    end

    it "updates session when no workspaces are found" do
      subject = described_class.new File.expand_path("../../support", __dir__)
      session = {
        "workspaces" => {
          "recent_workspaces" => []
        }
      }

      subject.rebuild_recent_workspaces
      updated_session = JSON.parse File.read(described_class.session_path)
      FileUtils.cp session_backup_file, session_file

      expect(updated_session).to eq(session)
    end

    it "skips updating session when session file is missing" do
      bogus_session_file = File.expand_path "../../support/bogus.sublime_session", __dir__
      allow(described_class).to receive_messages session_path: bogus_session_file

      subject.rebuild_recent_workspaces

      expect(File.exist?(bogus_session_file)).to eq(false)
    end

    it "skips updating session when keys are missing" do
      bogus_session_file = File.expand_path "../../support/Session.missing_keys", __dir__
      allow(described_class).to receive_messages session_path: bogus_session_file

      subject.rebuild_recent_workspaces
      updated_session = JSON.parse File.read(described_class.session_path)
      FileUtils.cp session_backup_file, session_file

      expect(updated_session).to eq({})
    end
  end
end
