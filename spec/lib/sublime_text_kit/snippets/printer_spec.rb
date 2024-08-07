# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Snippets::Printer do
  using Refinements::StringIO

  subject(:printer) { described_class.new }

  include_context "with application dependencies"

  describe "#call" do
    context "with snippets" do
      it "prints ASCII Doc snippets" do
        printer.call "*"

        expect(io.reread).to eq(<<~CONTENT)
          * Ruby Then (multiple line) - `thenm`
          * Ruby Then (proc) - `thenp`
          * Ruby Then (single line) - `then`
        CONTENT
      end

      it "prints Markdown snippets", :aggregate_failures do
        printer.call "-"

        expect(io.reread).to eq(<<~CONTENT)
          - Ruby Then (multiple line) - `thenm`
          - Ruby Then (proc) - `thenp`
          - Ruby Then (single line) - `then`
        CONTENT
      end
    end

    context "without snippets" do
      it "prints nothing" do
        settings.user_dir = temp_dir
        printer.call "*"

        expect(io.reread).to eq("")
      end
    end
  end
end
