# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Actions::Metadata::Delete do
  using Refinements::Pathname

  subject(:action) { described_class.new }

  include_context "with application dependencies"

  describe "#call" do
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
  end
end
