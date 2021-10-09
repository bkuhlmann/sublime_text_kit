# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Actions::Snippets do
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
      configuration.snippets_format = :ascii_doc
      expectation = proc { action.call }

      expect(&expectation).to output(ascii_doc).to_stdout
    end

    it "prints Markdown" do
      configuration.snippets_format = :markdown
      expectation = proc { action.call }

      expect(&expectation).to output(markdown).to_stdout
    end

    it "fails when unknown format is used" do
      configuration.snippets_format = :bogus
      expectation = proc { action.call }

      expect(&expectation).to output(
        "Invalid snippet format (must be a symbol): bogus. Use: :ascii_doc or :markdown.\n"
      ).to_stdout
    end
  end
end
