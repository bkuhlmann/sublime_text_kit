# frozen_string_literal: true

require "dry/container/stub"

RSpec.shared_context "with application container" do
  using Refinements::Structs

  include_context "with temporary directory"

  let(:container) { SublimeTextKit::Container }

  let :configuration do
    SublimeTextKit::CLI::Configuration::Loader.with_defaults.call.merge(
      project_roots: [Bundler.root.join("spec/support/fixtures/projects")],
      metadata_dir: temp_dir,
      session_path: temp_dir.join("Session.sublime_session"),
      user_dir: Bundler.root.join("spec/support/fixtures/snippets")
    )
  end

  let(:kernel) { class_spy Kernel }

  before do
    container.enable_stubs!
    container.stub :configuration, configuration
    container.stub :kernel, kernel
  end

  after { container.unstub :kernel }
end
