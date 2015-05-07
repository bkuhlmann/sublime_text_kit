require "spec_helper"

describe SublimeTextKit::Metadata::Workspace, :temp_dir do
  let(:projects_dir) { File.expand_path("../../../../support/projects", __FILE__) }
  let(:project_dir) { File.join projects_dir, "test" }
  subject { described_class.new project_dir, temp_dir }

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
end
