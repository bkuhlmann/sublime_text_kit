require "spec_helper"

describe SublimeTextKit::Metadata::Project, :temp_dir do
  let(:projects_dir) { File.expand_path("../../../../support/projects", __FILE__) }
  let(:project_dir) { File.join projects_dir, "test_1" }
  subject { described_class.new project_dir, temp_dir }

  describe "#file_extension" do
    it "answers file extension" do
      expect(subject.file_extension).to eq("sublime-project")
    end
  end

  describe "#to_h" do
    it "answers hash with project path" do
      proof = {
        folders: [
          {path: "#{project_dir}"}
        ]
      }

      expect(subject.to_h).to eq(proof)
    end
  end
end
