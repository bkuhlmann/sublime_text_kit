# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Metadata::Base do
  subject(:base) { described_class.new project_dir, temp_dir }

  include_context "with temporary directory"

  let(:projects_dir) { Bundler.root.join "spec", "support", "projects" }
  let(:project_dir) { File.join projects_dir, "test" }

  it_behaves_like "sublime metadata" do
    let(:metadata) { base }
  end

  describe "#file_extension" do
    it "answers file extension" do
      expect(base.file_extension).to eq("sublime-unknown")
    end
  end

  describe "#to_h" do
    it "answers empty hash" do
      expect(base.to_h).to eq({})
    end
  end

  describe "#save" do
    it "saves metadata as empty hash" do
      base.save
      metadata = JSON.parse File.read(base.metadata_file)

      expect(metadata).to eq({})
    end
  end
end
