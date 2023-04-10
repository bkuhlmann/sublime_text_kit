# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Actions::Metadata do
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

    it "deletes metadata" do
      Bundler.root
             .join("spec/support/fixtures/fixtures/metadata")
             .files
             .each { |path| path.copy temp_dir }
      action.call :delete

      expect(temp_dir.files.empty?).to be(true)
    end

    it "logs metadata being deleted" do
      action.call :delete

      expect(logger.reread).to match(
        /🟢.+Deleting metadata in #{temp_dir}....+\n🟢.+Metadata deleted./
      )
    end

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

    it "fails when given invalid action" do
      action.call :bogus
      expect(logger.reread).to match(/🛑.+Unknown metadata action: bogus./)
    end
  end
end
