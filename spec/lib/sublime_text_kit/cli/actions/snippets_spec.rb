# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Actions::Snippets do
  using Refinements::StringIO

  subject(:action) { described_class.new }

  include_context "with application dependencies"

  describe "#call" do
    it "prints ASCII Doc" do
      action.call "ascii_doc"

      expect(io.reread).to eq(<<~CONTENT)
        * Ruby Then (multiple line) - `thenm`
        * Ruby Then (proc) - `thenp`
        * Ruby Then (single line) - `then`
      CONTENT
    end

    it "prints Markdown" do
      action.call "markdown"

      expect(io.reread).to eq(<<~CONTENT)
        - Ruby Then (multiple line) - `thenm`
        - Ruby Then (proc) - `thenp`
        - Ruby Then (single line) - `then`
      CONTENT
    end

    it "prints default without kind" do
      action.call

      expect(io.reread).to eq(<<~CONTENT)
        * Ruby Then (multiple line) - `thenm`
        * Ruby Then (proc) - `thenp`
        * Ruby Then (single line) - `then`
      CONTENT
    end

    it "fails when unknown format is used" do
      action.call "bogus"

      expect(logger.reread).to match(
        /🛑.+Invalid snippet format: bogus. Use ascii_doc or markdown\./
      )
    end
  end
end
