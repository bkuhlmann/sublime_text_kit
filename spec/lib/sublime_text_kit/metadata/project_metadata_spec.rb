# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Metadata::Project, :temp_dir do
  subject(:project) { described_class.new project_dir, temp_dir }

  let(:projects_dir) { Bundler.root.join "spec", "support", "projects" }
  let(:project_dir) { File.join projects_dir, "test" }

  it_behaves_like "sublime metadata" do
    let(:metadata) { project }
  end

  describe "#file_extension" do
    it "answers file extension" do
      expect(project.file_extension).to eq("sublime-project")
    end
  end

  describe "#to_h" do
    it "answers hash with project path" do
      proof = {
        folders: [
          {path: project_dir}
        ]
      }

      expect(project.to_h).to eq(proof)
    end
  end

  describe "#save" do
    it "saves metadata as empty hash" do
      project.save
      metadata = JSON.parse File.read(project.metadata_file)

      proof = {
        "folders" => [
          {"path" => project_dir}
        ]
      }

      expect(metadata).to eq(proof)
    end
  end
end
