# frozen_string_literal: true

RSpec.shared_context "with application dependencies" do
  include_context "with temporary directory"

  let :configuration do
    Etcher.new(SublimeTextKit::Container[:defaults])
          .call(
            project_roots: [SPEC_ROOT.join("support/fixtures/projects")],
            metadata_dir: temp_dir,
            session_path: temp_dir.join("Session.sublime_session"),
            user_dir: SPEC_ROOT.join("support/fixtures/snippets")
          )
          .bind(&:dup)
  end

  let(:kernel) { class_spy Kernel }
  let(:logger) { Cogger.new id: :sublime_text_kit, io: StringIO.new }

  before { SublimeTextKit::Container.stub! configuration:, kernel:, logger: }

  after { SublimeTextKit::Container.restore }
end
