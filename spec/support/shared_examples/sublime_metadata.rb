# frozen_string_literal: true

RSpec.shared_examples "sublime metadata" do
  describe ".create" do
    it "creates metadata for all projects in projects root directory" do
      described_class.create projects_dir, temp_dir

      files = %w[black red white].map do |name|
        File.join temp_dir, "#{name}.#{metadata.file_extension}"
      end

      created = files.all? { |path| File.exist? path }

      expect(created).to be(true)
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
      FileUtils.touch metadata.metadata_file
      described_class.delete temp_dir

      expect(File.exist?(metadata.metadata_file)).to be(false)
    end

    it "does not delete non-metadata files" do
      test_file = File.join temp_dir, "test.txt"
      FileUtils.touch test_file
      described_class.delete temp_dir

      expect(File.exist?(test_file)).to be(true)
    end

    it "does not delete directories" do
      test_dir = File.join temp_dir, "test"
      FileUtils.mkdir test_dir
      described_class.delete temp_dir

      expect(File.exist?(test_dir)).to be(true)
    end

    it "outputs error message when metadata directory does not exist" do
      bogus_dir = File.join Dir.pwd, "bogus"
      result = -> { described_class.delete bogus_dir }

      expect(&result).to output("Metadata directory doesn't exist: #{bogus_dir}.\n").to_stdout
    end
  end

  describe "#name" do
    it "answers project name" do
      expect(metadata.name).to eq("test")
    end
  end

  describe "#project_dir" do
    it "answers absolute path" do
      metadata = described_class.new "~/tmp", temp_dir
      expect(metadata.project_dir).not_to start_with("~")
    end
  end

  describe "#metadata_dir" do
    it "answers absolute path" do
      metadata = described_class.new project_dir, "~/tmp"
      expect(metadata.metadata_dir).not_to start_with("~")
    end
  end

  describe "#metadata_file" do
    it "answers absolute path" do
      metadata = described_class.new project_dir, "~/tmp"
      expect(metadata.metadata_file).not_to start_with("~")
    end

    it "answers metadata file" do
      metadata_file = File.join metadata.metadata_dir, "#{metadata.name}.#{metadata.file_extension}"
      expect(metadata.metadata_file).to eq(metadata_file)
    end
  end

  describe "#save" do
    it "saves metadata to file" do
      metadata.save
      expect(File.exist?(metadata.metadata_file)).to be(true)
    end

    it "does not save metadata when file exists" do
      FileUtils.touch metadata.metadata_file
      expect(File.empty?(metadata.metadata_file)).to be(true)
    end
  end
end
