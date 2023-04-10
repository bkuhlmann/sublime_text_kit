# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Actions::Update do
  using Refinements::Pathnames

  subject(:action) { described_class.new session: }

  include_context "with application dependencies"

  let(:session) { instance_spy SublimeTextKit::Sessions::Rebuilder }

  describe "#call" do
    it "creates metadata" do
      action.call
      file_names = temp_dir.files.map { |path| path.basename.to_s }

      expect(file_names).to contain_exactly(
        "black.sublime-project",
        "black.sublime-workspace",
        "red.sublime-project",
        "red.sublime-workspace",
        "white.sublime-project",
        "white.sublime-workspace"
      )
    end

    it "rebuilds session" do
      action.call
      expect(session).to have_received(:call)
    end

    it "logs status" do
      action.call

      expect(logger.reread).to match(
        /🟢.+Updating metadata and session....+\n🟢.+Metadata and session updated./
      )
    end
  end
end
