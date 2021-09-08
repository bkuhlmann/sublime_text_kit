# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Metadata::Serializers::Workspace do
  subject(:serializer) { described_class.new pathway }

  let :pathway do
    SublimeTextKit::Metadata::Pathway[project_dir: project_dir, metadata_dir: metadata_dir]
  end

  let(:project_dir) { Bundler.root.join("project").to_s }
  let(:metadata_dir) { Bundler.root.join "metadata" }

  describe "#pathway" do
    it "answers pathway" do
      expect(serializer.pathway).to eq(pathway)
    end
  end

  describe "#to_h" do
    it "answers hash" do
      expect(serializer.to_h).to eq(
        {
          expanded_folders: [project_dir],
          select_project: {
            selected_items: [
              ["project", metadata_dir.join("project.sublime-project").to_s]
            ]
          }
        }
      )
    end
  end
end
