# frozen_string_literal: true

require "rexml/document"
require "spec_helper"

RSpec.describe SublimeTextKit::Snippets::Model do
  subject(:model) { described_class.new }

  describe ".for" do
    let(:document) { REXML::Document.new xml }

    let :xml do
      <<~CONTENT
        <snippet>\n
          <content><![CDATA[reduce(0, :+)]]></content>\n
          <tabTrigger>sum</tabTrigger>\n
          <description>Ruby Sum</description>\n
          <scope>source.ruby, source.rails</scope>\n
        </snippet>\n
      CONTENT
    end

    it "answers record for XML document" do
      expect(described_class.for(document)).to eq(
        described_class[
          content: "reduce(0, :+)",
          trigger: "sum",
          description: "Ruby Sum",
          scope: "source.ruby, source.rails"
        ]
      )
    end

    it "answers empty record for empty XML document" do
      expect(described_class.for(REXML::Document.new("<snippet></snippet>"))).to eq(
        described_class.new
      )
    end

    it "answers empty record for invalid XML document" do
      expect(described_class.for(REXML::Document.new("bogus"))).to eq(described_class.new)
    end

    it "answers empty record for new XML document" do
      expect(described_class.for(REXML::Document.new)).to eq(described_class.new)
    end
  end

  describe "#initialize" do
    it "freezes instance" do
      expect(model.frozen?).to be(true)
    end
  end
end
