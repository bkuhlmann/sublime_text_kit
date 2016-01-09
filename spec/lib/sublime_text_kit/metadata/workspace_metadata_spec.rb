require "spec_helper"

RSpec.describe SublimeTextKit::Metadata::Workspace, :temp_dir do
  let(:projects_dir) { File.expand_path("../../../../support/projects", __FILE__) }
  let(:project_dir) { File.join projects_dir, "test" }
  subject { described_class.new project_dir, temp_dir }

  it_behaves_like "sublime metadata"

  describe "#file_extension" do
    it "answers file extension" do
      expect(subject.file_extension).to eq("sublime-workspace")
    end
  end

  describe "#to_h" do
    it "answers hash with project path" do
      proof = {
        expanded_folders: ["#{project_dir}"],
        select_project: {
          selected_items: [
            ["test", "#{temp_dir}/test.sublime-project"]
          ]
        }
      }

      expect(subject.to_h).to eq(proof)
    end
  end

  describe "#save" do
    it "saves metadata as empty hash" do
      subject.save
      metadata = MultiJson.load File.read(subject.metadata_file)

      proof = {
        "expanded_folders" => ["#{project_dir}"],
        "select_project" => {
          "selected_items" => [
            ["test", "#{temp_dir}/test.sublime-project"]
          ]
        }
      }

      expect(metadata).to eq(proof)
    end
  end
end
