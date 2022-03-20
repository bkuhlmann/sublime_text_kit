# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Actions::Snippets do
  using Refinements::StringIOs

  subject(:action) { described_class.new }

  include_context "with application container"

  describe "#call" do
    let :ascii_doc do
      <<~CONTENT
        * Ruby Then (multiple line) - `thenm`
        * Ruby Then (proc) - `thenp`
        * Ruby Then (single line) - `then`
      CONTENT
    end

    let :markdown do
      <<~CONTENT
        - Ruby Then (multiple line) - `thenm`
        - Ruby Then (proc) - `thenp`
        - Ruby Then (single line) - `then`
      CONTENT
    end

    it "prints ASCII Doc" do
      action.call :ascii_doc
      expect(io.reread).to eq(ascii_doc)
    end

    it "prints Markdown" do
      action.call :markdown
      expect(io.reread).to eq(markdown)
    end

    it "fails when unknown format is used" do
      action.call "bogus"
      expect(io.reread).to eq("Invalid snippet format: bogus. Use ascii_doc or markdown.\n")
    end
  end
end
