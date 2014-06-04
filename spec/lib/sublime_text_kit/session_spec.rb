require "spec_helper"

describe SublimeTextKit::Session do
  subject { SublimeTextKit::Session.new workspaces_path: File.expand_path("../../../support/workspaces", __FILE__) }
  let(:session_file) { File.expand_path "../../../support/Session.sublime_session", __FILE__ }
  let(:session_backup_file) { File.expand_path "../../../support/Session.backup", __FILE__ }
  before { allow(SublimeTextKit::Session).to receive_messages session_path: session_file }

  describe "#workspaces_absolute_path" do
    it "expands to absolute path" do
      subject.workspaces_path = "~/some/random/path"
      segments = subject.workspaces_absolute_path.to_s.split File::SEPARATOR

      segments.each { |segment| expect(segment).not_to eq('~') }
    end
  end

  describe "#workspaces" do
    it "answers an alpha-sorted list of sublime project files" do
      project_files = %W(
        #{subject.workspaces_path}/black.sublime-project
        #{subject.workspaces_path}/red.sublime-project
        #{subject.workspaces_path}/white.sublime-project
      )

      expect(subject.workspaces).to eq(project_files)
    end
  end

  describe "#rebuild_recent_workspaces" do
    it "updates session when workspaces are found" do
      session = {
        "workspaces" => {
          "recent_workspaces" => [
            "#{subject.workspaces_path}/black.sublime-project",
            "#{subject.workspaces_path}/red.sublime-project",
            "#{subject.workspaces_path}/white.sublime-project"
          ]
        }
      }

      subject.rebuild_recent_workspaces
      updated_session = JSON.load File.read(SublimeTextKit::Session.session_path)
      FileUtils.cp session_backup_file, session_file

      expect(updated_session).to eq(session)
    end

    it "updates session when no workspaces are found" do
      subject.workspaces_path = File.expand_path("../../../support", __FILE__)
      session = {
        "workspaces" => {
          "recent_workspaces" => []
        }
      }

      subject.rebuild_recent_workspaces
      updated_session = JSON.load File.read(SublimeTextKit::Session.session_path)
      FileUtils.cp session_backup_file, session_file

      expect(updated_session).to eq(session)
    end

    it "skips updating the session when session file is not found" do
      bogus_session_file = File.expand_path "../../../support/bogus.sublime_session", __FILE__
      allow(SublimeTextKit::Session).to receive_messages session_path: bogus_session_file

      subject.rebuild_recent_workspaces

      expect(File.exists?(bogus_session_file)).to be_falsey
    end

    it "skips updating the session when keys are missing" do
      bogus_session_file = File.expand_path "../../../support/Session.missing_keys", __FILE__
      allow(SublimeTextKit::Session).to receive_messages session_path: bogus_session_file

      subject.rebuild_recent_workspaces
      updated_session = JSON.load File.read(SublimeTextKit::Session.session_path)
      FileUtils.cp session_backup_file, session_file

      expect(updated_session).to eq({})
    end
  end
end
