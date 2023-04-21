# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Actions::Metadata::Create do
  using Refinements::Pathnames

  subject(:action) { described_class.new }

  include_context "with application dependencies"

  describe "#call" do
    it "creates metadata" do
      action.call :create
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

    it "logs metadata being created" do
      action.call :create

      expect(logger.reread).to match(
        /🟢.+Creating metadata in #{temp_dir}....+\n🟢.+Metadata created./
      )
    end
  end
end
