# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Actions::Update do
  using Refinements::Pathnames

  subject(:action) { described_class.new session: }

  include_context "with application container"

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
      expectation = proc { action.call }
      message = "Updating metadata and session...\nMetadata and session updated.\n"

      expect(&expectation).to output(message).to_stdout
    end
  end
end
