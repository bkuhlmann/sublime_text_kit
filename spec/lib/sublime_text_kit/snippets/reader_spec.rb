# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Snippets::Reader do
  subject(:reader) { described_class.new }

  include_context "with application container"

  describe "#call" do
    it "answers record read from valid file path" do
      path = Bundler.root.join "spec/support/fixtures/snippets/ruby-then-proc.sublime-snippet"

      expect(reader.call(path)).to eq(
        SublimeTextKit::Snippets::Model[
          content: "then(&method(:$1))",
          trigger: "thenp",
          description: "Ruby Then (proc)",
          scope: "source.ruby, source.rails"
        ]
      )
    end

    it "answers empty record read from invalid file path" do
      path = Bundler.root.join "spec/support/snippets/bogus.sublime-snippet"
      expect(reader.call(path)).to eq(SublimeTextKit::Snippets::Model.new)
    end
  end
end
