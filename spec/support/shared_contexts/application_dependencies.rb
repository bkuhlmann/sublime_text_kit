# frozen_string_literal: true

require "dry/container/stub"
require "infusible/stub"

RSpec.shared_context "with application dependencies" do
  using Refinements::Structs
  using Infusible::Stub

  include_context "with temporary directory"

  let :configuration do
    SublimeTextKit::Container[:configuration].merge(
      project_roots: [SPEC_ROOT.join("support/fixtures/projects")],
      metadata_dir: temp_dir,
      session_path: temp_dir.join("Session.sublime_session"),
      user_dir: SPEC_ROOT.join("support/fixtures/snippets")
    )
  end

  let(:kernel) { class_spy Kernel }
  let(:logger) { Cogger.new io: StringIO.new, formatter: :emoji }

  before { SublimeTextKit::Import.stub configuration:, kernel:, logger: }

  after { SublimeTextKit::Import.unstub :configuration, :kernel, :logger }
end
