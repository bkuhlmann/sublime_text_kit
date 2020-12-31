# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Metadata::Workspace do
  subject(:workspace) { described_class.new project_dir, temp_dir }

  include_context "with temporary directory"

  let(:projects_dir) { Bundler.root.join "spec", "support", "projects" }
  let(:project_dir) { File.join projects_dir, "test" }

  it_behaves_like "sublime metadata" do
    let(:metadata) { workspace }
  end

  describe "#file_extension" do
    it "answers file extension" do
      expect(workspace.file_extension).to eq("sublime-workspace")
    end
  end

  describe "#to_h" do
    it "answers hash with project path" do
      proof = {
        expanded_folders: [project_dir],
        select_project: {
          selected_items: [
            ["test", "#{temp_dir}/test.sublime-project"]
          ]
        }
      }

      expect(workspace.to_h).to eq(proof)
    end
  end

  describe "#save" do
    let :proof do
      {
        "expanded_folders" => [project_dir],
        "select_project" => {
          "selected_items" => [
            ["test", "#{temp_dir}/test.sublime-project"]
          ]
        }
      }
    end

    it "saves metadata as empty hash" do
      workspace.save
      metadata = JSON.parse File.read(workspace.metadata_file)

      expect(metadata).to eq(proof)
    end
  end
end
