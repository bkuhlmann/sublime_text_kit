# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Snippets::Printers::ASCIIDoc do
  subject(:printer) { described_class.new }

  include_context "with application container"

  describe "#call" do
    context "with snippets" do
      it "prints snippets" do
        expectation = -> { printer.call }
        results = "* Ruby Then (multiple line) - `thenm`\n" \
                  "* Ruby Then (proc) - `thenp`\n" \
                  "* Ruby Then (single line) - `then`\n"

        expect(&expectation).to output(results).to_stdout
      end
    end

    context "without snippets" do
      it "prints nothing" do
        configuration.user_dir = temp_dir
        expectation = -> { printer.call }

        expect(&expectation).to output("").to_stdout
      end
    end
  end
end
