# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Metadata::Handler do
  using Refinements::Pathnames

  subject(:handler) { described_class.new "sublime-project", serializer: }

  include_context "with temporary directory"

  let :serializer do
    SublimeTextKit::Metadata::Serializers::Project.new(
      SublimeTextKit::Metadata::Pathway[
        project_dir: Bundler.root.join("spec/support/fixtures/projects/black"),
        metadata_dir: temp_dir
      ]
    )
  end

  let(:test_path) { temp_dir.join "black.sublime-project" }

  describe "#with_project" do
    it "handles project" do
      handler = described_class.with_project Bundler.root
                                                    .join("spec/support/fixtures/projects/black"),
                                             temp_dir
      expect(handler.recreate).to eq(test_path)
    end
  end

  describe "#with_workspace" do
    it "handles project" do
      handler = described_class.with_workspace Bundler.root
                                                      .join("spec/support/fixtures/projects/black"),
                                               temp_dir
      expect(handler.recreate).to eq(temp_dir.join("black.sublime-workspace"))
    end
  end

  describe "#create" do
    it "writes project metadata when file doesn't exist" do
      handler.create
      content = JSON test_path.read, symbolize_names: true

      expect(content).to eq(
        folders: [{path: "#{Bundler.root}/spec/support/fixtures/projects/black"}]
      )
    end

    it "answers path when path doesn't exist" do
      expect(handler.create).to eq(test_path)
    end

    it "doesn't write metadata when file exists" do
      test_path.write Hash.new
      handler.create

      expect(JSON(test_path.read)).to eq({})
    end

    it "answers path when path exists" do
      test_path.write Hash.new
      expect(handler.create).to eq(test_path)
    end
  end

  describe "#delete" do
    it "deletes metadata when metadata exists" do
      handler.create
      handler.delete

      expect(test_path.exist?).to be(false)
    end

    it "answers path when metadata exists" do
      handler.create
      expect(handler.delete).to eq(test_path)
    end

    it "does nothing when there is nothing to delete" do
      handler.delete
      expect(test_path.exist?).to be(false)
    end

    it "answers path when there is nothing to delete" do
      expect(handler.delete).to eq(test_path)
    end
  end

  describe "#recreate" do
    it "recreates metadata when metadata exists" do
      test_path.write Hash.new
      handler.recreate
      content = JSON test_path.read, symbolize_names: true

      expect(content).to eq(
        folders: [{path: "#{Bundler.root}/spec/support/fixtures/projects/black"}]
      )
    end

    it "recreates metadata when metadata doesn't exist" do
      handler.recreate
      content = JSON test_path.read, symbolize_names: true

      expect(content).to eq(
        folders: [{path: "#{Bundler.root}/spec/support/fixtures/projects/black"}]
      )
    end

    it "answers metadata path" do
      expect(handler.recreate).to eq(test_path)
    end
  end
end
