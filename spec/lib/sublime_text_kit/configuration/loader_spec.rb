# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Configuration::Loader do
  subject(:loader) { described_class.with_defaults }

  let :content do
    SublimeTextKit::Configuration::Content[
      project_roots: nil,
      metadata_dir: nil,
      snippets_format: :ascii_doc,
      session_path: Pathname(
        %(#{home_dir}/Library/Application Support/Sublime Text/Local/Session.sublime_session)
      ),
      user_dir: Pathname(%(#{home_dir}/Library/Application Support/Sublime Text/Packages/User))
    ]
  end

  let(:home_dir) { Dir.home }

  describe ".call" do
    it "answers default configuration" do
      expect(described_class.call).to be_a(SublimeTextKit::Configuration::Content)
    end
  end

  describe ".with_defaults" do
    it "answers default configuration" do
      expect(described_class.with_defaults.call).to eq(content)
    end
  end

  describe "#call" do
    it "answers default configuration" do
      expect(loader.call).to eq(content)
    end
  end
end
