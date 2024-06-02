# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Snippets::Collector do
  subject(:collection) { described_class.new }

  include_context "with application dependencies"

  describe "#call" do
    let :records do
      [
        SublimeTextKit::Snippets::Model[
          content: "\n",
          trigger: "thenm",
          description: "Ruby Then (multiple line)",
          scope: "source.ruby, source.rails"
        ],
        SublimeTextKit::Snippets::Model[
          content: "then(&method(:$1))",
          trigger: "thenp",
          description: "Ruby Then (proc)",
          scope: "source.ruby, source.rails"
        ],
        SublimeTextKit::Snippets::Model[
          content: "then { |$1| $2 }",
          trigger: "then",
          description: "Ruby Then (single line)",
          scope: "source.ruby, source.rails"
        ]
      ]
    end

    it "answers snippets when snippets exist" do
      expect(collection.call).to eq(records)
    end

    it "sorts by description when snippets exist" do
      expect(collection.call.map(&:description)).to eq(
        [
          "Ruby Then (multiple line)",
          "Ruby Then (proc)",
          "Ruby Then (single line)"
        ]
      )
    end

    it "answers empty array when snippets don't exist" do
      settings.user_dir = temp_dir
      expect(collection.call).to eq([])
    end
  end
end
