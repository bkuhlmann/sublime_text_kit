# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Sessions::Rebuilder do
  using Refinements::Pathnames
  using Refinements::Structs

  subject(:session) { described_class.new }

  include_context "with application dependencies"

  let(:session_fixture) { SPEC_ROOT.join "support/fixtures/Session.sublime_session" }

  before do
    configuration.metadata_dir = SPEC_ROOT.join "support/fixtures/metadata"
    session_fixture.copy configuration.session_path
  end

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

    it "updates session when session and metadata exists" do
      session.call
      expect(JSON(configuration.session_path.read)).to eq(workspaces)
    end

    it "updates session with empty workspaces with no metadata" do
      configuration.metadata_dir = temp_dir
      session.call

      expect(JSON(configuration.session_path.read)).to eq(
        "workspaces" => {"recent_workspaces" => []}
      )
    end

    it "doesn't create session when session file is missing" do
      configuration.session_path.delete
      session.call

      expect(configuration.session_path.exist?).to be(false)
    end

    context "with missing session keys" do
      let(:session_fixture) { SPEC_ROOT.join "support/fixtures/Session.missing_keys" }

      it "updates session with empty hash" do
        session.call
        expect(JSON(configuration.session_path.read)).to eq({})
      end
    end
  end
end
