# frozen_string_literal: true

RSpec.shared_examples_for "sublime metadata" do
  describe ".create" do
    it "creates metadata for all projects in projects root directory" do
      described_class.create projects_dir, temp_dir
      files = %w(black red white).map { |name| File.join temp_dir, "#{name}.#{subject.file_extension}" }
      created = files.all? { |path| File.exist? path }

      expect(created).to eq(true)
    end

    it "outputs error message when projects directory does not exist" do
      bogus_dir = File.join Dir.pwd, "bogus"
      result = -> { described_class.create bogus_dir, temp_dir }

      expect(&result).to output("Projects directory doesn't exist: #{bogus_dir}.\n").to_stdout
    end

    it "outputs error message when metadata directory does not exist" do
      bogus_dir = File.join Dir.pwd, "bogus"
      result = -> { described_class.create projects_dir, bogus_dir }

      expect(&result).to output("Metadata directory doesn't exist: #{bogus_dir}.\n").to_stdout
    end
  end

  describe ".delete" do
    it "deletes *.sublime-* metadata files" do
      FileUtils.touch subject.metadata_file
      described_class.delete temp_dir

      expect(File.exist?(subject.metadata_file)).to eq(false)
    end

    it "does not delete non-metadata files" do
      test_file = File.join temp_dir, "test.txt"
      FileUtils.touch test_file
      described_class.delete temp_dir

      expect(File.exist?(test_file)).to eq(true)
    end

    it "does not delete directories" do
      test_dir = File.join temp_dir, "test"
      FileUtils.mkdir test_dir
      described_class.delete temp_dir

      expect(File.exist?(test_dir)).to eq(true)
    end

    it "outputs error message when metadata directory does not exist" do
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
      expect(subject.project_dir).to_not start_with("~")
    end
  end

  describe "#metadata_dir" do
    it "answers absolute path" do
      subject = described_class.new project_dir, "~/tmp"
      expect(subject.metadata_dir).to_not start_with("~")
    end
  end

  describe "#metadata_file" do
    it "answers absolute path" do
      subject = described_class.new project_dir, "~/tmp"
      expect(subject.metadata_file).to_not start_with("~")
    end

    it "answers metadata file" do
      metadata_file = File.join subject.metadata_dir, "#{subject.name}.#{subject.file_extension}"
      expect(subject.metadata_file).to eq(metadata_file)
    end
  end

  describe "#save" do
    it "saves metadata to file" do
      subject.save
      expect(File.exist?(subject.metadata_file)).to eq(true)
    end

    it "does not save metadata when file exists" do
      FileUtils.touch subject.metadata_file
      expect(File.zero?(subject.metadata_file)).to eq(true)
    end
  end
end
