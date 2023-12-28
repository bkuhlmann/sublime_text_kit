# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Actions::Metadata::Recreate do
  using Refinements::Pathname

  subject(:action) { described_class.new }

  include_context "with application dependencies"

  describe "#call" do
    it "recreates metadata" do
      action.call :recreate
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

    it "logs metadata being recreated" do
      action.call :recreate

      expect(logger.reread).to match(
        /🟢.+Recreating metadata in #{temp_dir}....+\n🟢.+Metadata recreated./
      )
    end
  end
end
