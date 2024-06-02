# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Snippets::Printer do
  subject(:printer) { described_class.new }

  include_context "with application dependencies"

  describe "#call" do
    context "with snippets" do
      it "prints ASCII Doc snippets", :aggregate_failures do
        printer.call "*"

        expect(kernel).to have_received(:puts).with("* Ruby Then (multiple line) - `thenm`")
        expect(kernel).to have_received(:puts).with("* Ruby Then (proc) - `thenp`")
        expect(kernel).to have_received(:puts).with("* Ruby Then (single line) - `then`")
      end

      it "prints Markdown snippets", :aggregate_failures do
        printer.call "-"

        expect(kernel).to have_received(:puts).with("- Ruby Then (multiple line) - `thenm`")
        expect(kernel).to have_received(:puts).with("- Ruby Then (proc) - `thenp`")
        expect(kernel).to have_received(:puts).with("- Ruby Then (single line) - `then`")
      end
    end

    context "without snippets" do
      it "prints nothing" do
        settings.user_dir = temp_dir
        printer.call "*"

        expect(kernel).not_to have_received(:puts)
      end
    end
  end
end
