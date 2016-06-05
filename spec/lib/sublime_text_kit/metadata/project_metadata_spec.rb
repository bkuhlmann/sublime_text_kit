# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Metadata::Project, :temp_dir do
  let(:projects_dir) { File.expand_path("../../../../support/projects", __FILE__) }
  let(:project_dir) { File.join projects_dir, "test" }
  subject { described_class.new project_dir, temp_dir }

  it_behaves_like "sublime metadata"

  describe "#file_extension" do
    it "answers file extension" do
      expect(subject.file_extension).to eq("sublime-project")
    end
  end

  describe "#to_h" do
    it "answers hash with project path" do
      proof = {
        folders: [
          {path: project_dir}
        ]
      }

      expect(subject.to_h).to eq(proof)
    end
  end

  describe "#save" do
    it "saves metadata as empty hash" do
      subject.save
      metadata = JSON.load File.read(subject.metadata_file)

      proof = {
        "folders" => [
          {"path" => project_dir}
        ]
      }

      expect(metadata).to eq(proof)
    end
  end
end
