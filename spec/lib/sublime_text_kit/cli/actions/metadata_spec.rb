# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Actions::Metadata do
  using Refinements::Pathnames

  subject(:action) { described_class.new }

  include_context "with application container"

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
      expectation = proc { action.call :create }
      message = "Creating metadata in #{temp_dir}...\nMetadata created.\n"

      expect(&expectation).to output(message).to_stdout
    end

    it "deletes metadata" do
      Bundler.root
             .join("spec/support/fixtures/fixtures/metadata")
             .files
             .each { |path| path.copy temp_dir }
      action.call :delete

      expect(temp_dir.files.empty?).to eq(true)
    end

    it "logs metadata being deleted" do
      expectation = proc { action.call :delete }
      message = "Deleting metadata in #{temp_dir}...\nMetadata deleted.\n"

      expect(&expectation).to output(message).to_stdout
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
      expectation = proc { action.call :recreate }
      message = "Recreating metadata in #{temp_dir}...\nMetadata recreated.\n"

      expect(&expectation).to output(message).to_stdout
    end

    it "fails when given invalid action" do
      expectation = proc { action.call :bogus }
      expect(&expectation).to output("Unknown metadata action: bogus.\n").to_stdout
    end
  end
end
