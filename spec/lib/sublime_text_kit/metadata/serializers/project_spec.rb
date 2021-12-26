# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Metadata::Serializers::Project do
  subject(:serializer) { described_class.new pathway }

  let(:pathway) { SublimeTextKit::Metadata::Pathway[project_dir:] }
  let(:project_dir) { Bundler.root.join("test").to_s }

  describe "#pathway" do
    it "answers pathway" do
      expect(serializer.pathway).to eq(pathway)
    end
  end

  describe "#to_h" do
    it "answers hash" do
      expect(serializer.to_h).to eq({folders: [{path: project_dir}]})
    end
  end
end
