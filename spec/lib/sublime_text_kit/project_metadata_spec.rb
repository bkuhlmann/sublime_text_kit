require "spec_helper"

describe SublimeTextKit::ProjectMetadata do
  let(:projects_dir) { File.expand_path("../../../support/projects", __FILE__) }
  let(:project_dir) { File.join projects_dir, "test_1" }
  subject { described_class.new project_dir, temp_dir }

  describe ".create" do
    it "creates project metadata for all project in root directory" do
      described_class.create projects_dir, temp_dir
      files = %w(test_1 test_2).map { |name| File.join temp_dir, "#{name}.sublime-project" }
      created = files.all? { |path| File.exist? path }

      expect(created).to eq(true)
    end
  end

  describe "#name" do
    it "answers project name" do
      expect(subject.name).to eq("test_1")
    end
  end

  describe "#project_dir" do
    it "answers absolute path" do
      subject = described_class.new "~/tmp", temp_dir
      expect(subject.project_dir).to_not start_with('~')
    end
  end

  describe "#workspaces_path" do
    it "answers absolute path" do
      subject = described_class.new project_dir, "~/tmp"
      expect(subject.workspaces_path).to_not start_with('~')
    end
  end

  describe "#project_file" do
    it "answers absolute file path" do
      subject = described_class.new project_dir, "~/tmp"
      expect(subject.project_file).to_not start_with('~')
    end

    it "answers metadata file path" do
      project_file = File.join subject.workspaces_path, "#{subject.name}.sublime-project"
      expect(subject.project_file).to eq(project_file)
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

  describe "#save", :temp_dir do
    it "saves metadata to file" do
      subject.save
      expect(File.exist?(subject.project_file)).to eq(true)
    end

    it "saves metadata with project path" do
      subject.save
      metadata = MultiJson.load File.read(subject.project_file)
      path = metadata["folders"].first["path"]

      expect(path).to eq(subject.project_dir)
    end

    it "does not save metadata if file already exists" do
      FileUtils.touch subject.project_file
      expect(File.zero?(subject.project_file)).to eq(true)
    end
  end
end
