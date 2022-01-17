# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Configuration::Loader do
  subject(:loader) { described_class.with_defaults }

  let :content do
    SublimeTextKit::Configuration::Content[
      action_config: nil,
      action_help: nil,
      action_metadata: nil,
      action_session: nil,
      action_snippets: nil,
      action_update: nil,
      action_version: nil,
      project_roots: nil,
      metadata_dir: nil,
      snippets_format: :ascii_doc,
      session_path: Pathname(
        %(#{ENV["HOME"]}/Library/Application Support/Sublime Text/Local/Session.sublime_session)
      ),
      user_dir: Pathname(%(#{ENV["HOME"]}/Library/Application Support/Sublime Text/Packages/User))
    ]
  end

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