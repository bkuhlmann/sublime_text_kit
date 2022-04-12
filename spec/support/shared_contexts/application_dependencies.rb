# frozen_string_literal: true

require "dry/container/stub"
require "auto_injector/stub"

RSpec.shared_context "with application dependencies" do
  using Refinements::Structs
  using AutoInjector::Stub

  include_context "with temporary directory"

  let :configuration do
    SublimeTextKit::Configuration::Loader.with_defaults.call.merge(
      project_roots: [Bundler.root.join("spec/support/fixtures/projects")],
      metadata_dir: temp_dir,
      session_path: temp_dir.join("Session.sublime_session"),
      user_dir: Bundler.root.join("spec/support/fixtures/snippets")
    )
  end

  let(:kernel) { class_spy Kernel }

  let :logger do
    Cogger::Client.new Logger.new(StringIO.new),
                       formatter: ->(_severity, _name, _at, message) { "#{message}\n" }
  end

  before { SublimeTextKit::Import.stub configuration:, kernel:, logger: }

  after { SublimeTextKit::Import.unstub :configuration, :kernel, :logger }
end