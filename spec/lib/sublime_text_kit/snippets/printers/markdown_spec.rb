# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Snippets::Printers::Markdown, :temp_dir do
  subject(:printer) { described_class.new environment: environment }

  let(:environment) { {"HOME" => temp_dir} }
  let(:support_path) { Bundler.root.join "spec/support/snippets" }
  let(:snippets_path) { temp_dir.join "Library/Application Support/Sublime Text 3/Packages/User" }

  describe "#call" do
    context "with snippets" do
      before do
        FileUtils.mkdir_p snippets_path
        FileUtils.cp_r "#{support_path}/.", snippets_path
      end

      it "prints snippets" do
        expectation = -> { printer.call }
        results = "- Ruby Then (multiple line) - `thenm`\n" \
                  "- Ruby Then (proc) - `thenp`\n" \
                  "- Ruby Then (single line) - `then`\n"

        expect(&expectation).to output(results).to_stdout
      end
    end

    context "without snippets" do
      it "prints nothing" do
        expectation = -> { printer.call }
        expect(&expectation).to output("").to_stdout
      end
    end
  end
end
