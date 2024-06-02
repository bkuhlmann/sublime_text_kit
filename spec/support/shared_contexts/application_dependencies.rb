# frozen_string_literal: true

RSpec.shared_context "with application dependencies" do
  using Refinements::Struct

  include_context "with temporary directory"

  let(:settings) { SublimeTextKit::Container[:settings] }
  let(:kernel) { class_spy Kernel }
  let(:logger) { Cogger.new id: :sublime_text_kit, io: StringIO.new }

  before do
    settings.merge! Etcher.call(
      SublimeTextKit::Container[:registry].remove_loader(2),
      project_roots: [SPEC_ROOT.join("support/fixtures/projects")],
      metadata_dir: temp_dir,
      session_path: temp_dir.join("Session.sublime_session"),
      user_dir: SPEC_ROOT.join("support/fixtures/snippets")
    )

    SublimeTextKit::Container.stub! kernel:, logger:
  end

  after { SublimeTextKit::Container.restore }
end
