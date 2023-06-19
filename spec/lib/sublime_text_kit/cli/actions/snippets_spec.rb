# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Actions::Snippets do
  subject(:action) { described_class.new }

  include_context "with application dependencies"

  describe "#call" do
    it "prints ASCII Doc" do
      action.call "ascii_doc"
      expect(kernel).to have_received(:puts).with("* Ruby Then (multiple line) - `thenm`")
    end

    it "prints Markdown" do
      action.call "markdown"
      expect(kernel).to have_received(:puts).with("- Ruby Then (multiple line) - `thenm`")
    end

    it "prints default without kind" do
      action.call
      expect(kernel).to have_received(:puts).with("* Ruby Then (multiple line) - `thenm`")
    end

    it "fails when unknown format is used" do
      action.call "bogus"

      expect(logger.reread).to match(
        /🛑.+Invalid snippet format: bogus. Use ascii_doc or markdown\./
      )
    end
  end
end
