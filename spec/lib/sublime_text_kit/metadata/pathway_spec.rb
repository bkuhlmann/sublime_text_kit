# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Metadata::Pathway do
  subject(:pathway) { described_class.new }

  include_context "with temporary directory"

  let(:project_name) { Bundler.root.basename }

  describe "#initialize" do
    it "answers default attributes" do
      expect(pathway).to have_attributes(
        project_dir: Pathname(Bundler.root),
        metadata_dir: Pathname(Bundler.root)
      )
    end
  end

  describe "#project_name" do
    it "answers name" do
      expect(pathway.project_name).to eq(project_name)
    end
  end

  describe "#metadata_file" do
    it "answers file path" do
      expect(pathway.metadata_file("sublime-project")).to eq(
        Bundler.root.join("#{project_name}.sublime-project")
      )
    end
  end
end
