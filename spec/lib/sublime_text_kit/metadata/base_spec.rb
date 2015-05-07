require "spec_helper"

describe SublimeTextKit::Metadata::Base, :temp_dir do
  let(:projects_dir) { File.expand_path("../../../../support/projects", __FILE__) }
  let(:project_dir) { File.join projects_dir, "test" }
  subject { described_class.new project_dir, temp_dir }

  describe ".create" do
    it "creates project metadata for all project in root directory" do
      described_class.create projects_dir, temp_dir
      files = %w(black red white).map { |name| File.join temp_dir, "#{name}.#{subject.file_extension}" }
      created = files.all? { |path| File.exist? path }

      expect(created).to eq(true)
    end

    it "outputs projects dir does not exist" do
      bogus_dir = File.join Dir.pwd, "bogus"
      result = -> { described_class.create bogus_dir, temp_dir }

      expect(&result).to output("Projects directory doesn't exist: #{bogus_dir}.\n").to_stdout
    end

    it "outputs metadata dir does not exist" do
      bogus_dir = File.join Dir.pwd, "bogus"
      result = -> { described_class.create projects_dir, bogus_dir }

      expect(&result).to output("Metadata directory doesn't exist: #{bogus_dir}.\n").to_stdout
    end
  end

  describe ".delete" do
    it "deletes *.sublime-project files" do
      FileUtils.touch subject.metadata_file
      described_class.delete temp_dir

      expect(File.exists?(subject.metadata_file)).to eq(false)
    end

    it "deletes *.sublime-workspace files" do
      workspace_file = File.join subject.metadata_dir, "test.sublime-unknown"
      FileUtils.touch workspace_file
      described_class.delete temp_dir

      expect(File.exists?(workspace_file)).to eq(false)
    end

    it "does not delete non-matching files" do
      test_file = File.join temp_dir, "test.txt"
      FileUtils.touch test_file
      described_class.delete temp_dir

      expect(File.exists?(test_file)).to eq(true)
    end

    it "does not delete directories" do
      test_dir = File.join temp_dir, "test"
      FileUtils.mkdir test_dir
      described_class.delete temp_dir

      expect(File.exists?(test_dir)).to eq(true)
    end

    it "outputs workspace dir does not exist" do
      bogus_dir = File.join Dir.pwd, "bogus"
      result = -> { described_class.delete bogus_dir }

      expect(&result).to output("Metadata directory doesn't exist: #{bogus_dir}.\n").to_stdout
    end
  end

  describe "#name" do
    it "answers project name" do
      expect(subject.name).to eq("test")
    end
  end

  describe "#project_dir" do
    it "answers absolute path" do
      subject = described_class.new "~/tmp", temp_dir
      expect(subject.project_dir).to_not start_with('~')
    end
  end

  describe "#metadata_dir" do
    it "answers absolute path" do
      subject = described_class.new project_dir, "~/tmp"
      expect(subject.metadata_dir).to_not start_with('~')
    end
  end

  describe "#metadata_file" do
    it "answers absolute file path" do
      subject = described_class.new project_dir, "~/tmp"
      expect(subject.metadata_file).to_not start_with('~')
    end

    it "answers metadata file path" do
      metadata_file = File.join subject.metadata_dir, "test.sublime-unknown"
      expect(subject.metadata_file).to eq(metadata_file)
    end
  end

  describe "#file_extension" do
    it "answers file extension" do
      expect(subject.file_extension).to eq("sublime-unknown")
    end
  end

  describe "#to_h" do
    it "answers empty hash" do
      expect(subject.to_h).to eq({})
    end
  end

  describe "#save" do
    it "saves metadata to file" do
      subject.save
      expect(File.exist?(subject.metadata_file)).to eq(true)
    end

    it "saves metadata as empty hash" do
      subject.save
      metadata = MultiJson.load File.read(subject.metadata_file)

      expect(metadata).to eq({})
    end

    it "does not save metadata if file already exists" do
      FileUtils.touch subject.metadata_file
      expect(File.zero?(subject.metadata_file)).to eq(true)
    end
  end
end
