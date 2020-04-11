# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Snippets::Collector, :temp_dir do
  subject(:collection) { described_class.new environment: environment }

  let(:environment) { {"HOME" => temp_dir} }
  let(:support_path) { Bundler.root.join "spec/support/snippets" }
  let(:snippets_path) { temp_dir.join "Library/Application Support/Sublime Text 3/Packages/User" }

  describe "#home_path" do
    it "answers path" do
      expect(collection.home_path).to eq(temp_dir)
    end
  end

  describe "#root_path" do
    it "answers path" do
      expect(collection.root_path).to eq(snippets_path)
    end
  end

  describe "#call" do
    context "with snippets" do
      before do
        FileUtils.mkdir_p snippets_path
        FileUtils.cp_r "#{support_path}/.", snippets_path
      end

      it "answers snippets" do
        expect(collection.call).to contain_exactly(
          kind_of(SublimeTextKit::Snippets::Snippet),
          kind_of(SublimeTextKit::Snippets::Snippet),
          kind_of(SublimeTextKit::Snippets::Snippet)
        )
      end

      it "sorts by description" do
        expect(collection.call.map(&:description)).to eq(
          [
            "Ruby Then (multiple line)",
            "Ruby Then (proc)",
            "Ruby Then (single line)"
          ]
        )
      end
    end

    context "without snippets" do
      it "answers empty array" do
        expect(collection.call).to eq([])
      end
    end
  end
end
