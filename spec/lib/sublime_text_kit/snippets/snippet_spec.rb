# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Snippets::Snippet do
  subject(:snippet) { described_class.new document }

  let(:document) { REXML::Document.new xml }

  let :xml do
    "<snippet>\n" \
    "  <content><![CDATA[reduce(0, :+)]]></content>\n" \
    "  <tabTrigger>sum</tabTrigger>\n" \
    "  <description>Ruby Sum</description>\n" \
    "  <scope>source.ruby, source.rails</scope>\n" \
    "</snippet>\n"
  end

  shared_examples_for "an attribute" do |method|
    context "with nil XML" do
      let(:xml) { nil }

      it "answers empty text" do
        expect(snippet.public_send(method)).to eq("")
      end
    end

    context "with random text" do
      let(:xml) { "invalid" }

      it "answers empty text" do
        expect(snippet.public_send(method)).to eq("")
      end
    end

    context "with invalid XML" do
      let(:xml) { "<x>invalidx>" }

      it "fails with parse exception" do
        result = -> { snippet.public_send method }
        expect(&result).to raise_error(REXML::ParseException, /No close tag/)
      end
    end
  end

  describe "#initialize" do
    context "with unknown element" do
      let :xml do
        "<snippet>\n" \
        "  <bogus>x</bogus>\n" \
        "</snippet>\n"
      end

      it "fails with standard error" do
        construction = -> { described_class.new document }
        expect(&construction).to raise_error(StandardError, "Unknown element: <bogus>x</bogus>.")
      end
    end
  end

  describe "#content" do
    context "with valid document" do
      it "answers content" do
        expect(snippet.content).to eq("reduce(0, :+)")
      end
    end

    it_behaves_like "an attribute", :content
  end

  describe "#trigger" do
    context "with valid document" do
      it "answers trigger" do
        expect(snippet.trigger).to eq("sum")
      end
    end

    it_behaves_like "an attribute", :trigger
  end

  describe "#description" do
    context "with valid document" do
      it "answers description" do
        expect(snippet.description).to eq("Ruby Sum")
      end
    end

    it_behaves_like "an attribute", :description
  end

  describe "#scope" do
    context "with valid document" do
      it "answers scope" do
        expect(snippet.scope).to eq("source.ruby, source.rails")
      end
    end

    it_behaves_like "an attribute", :scope
  end
end
