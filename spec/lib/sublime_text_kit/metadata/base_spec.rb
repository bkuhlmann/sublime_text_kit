# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Metadata::Base, :temp_dir do
  let(:projects_dir) { File.expand_path("../../../../support/projects", __FILE__) }
  let(:project_dir) { File.join projects_dir, "test" }
  subject { described_class.new project_dir, temp_dir }

  it_behaves_like "sublime metadata"

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
    it "saves metadata as empty hash" do
      subject.save
      metadata = MultiJson.load File.read(subject.metadata_file)

      expect(metadata).to eq({})
    end
  end
end
