# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Parsers::Core do
  subject(:parser) { described_class.new }

  include_context "with application container"

  it_behaves_like "a parser"

  describe "#call" do
    it "answers config edit (short)" do
      parser.call %w[-c edit]
      expect(configuration.action_config).to eq(:edit)
    end

    it "answers config edit (long)" do
      parser.call %w[--config edit]
      expect(configuration.action_config).to eq(:edit)
    end

    it "answers config view (short)" do
      parser.call %w[-c view]
      expect(configuration.action_config).to eq(:view)
    end

    it "answers config view (long)" do
      parser.call %w[--config view]
      expect(configuration.action_config).to eq(:view)
    end

    it "fails with missing config action" do
      expectation = proc { parser.call %w[--config] }
      expect(&expectation).to raise_error(OptionParser::MissingArgument, /--config/)
    end

    it "fails with invalid config action" do
      expectation = proc { parser.call %w[--config bogus] }
      expect(&expectation).to raise_error(OptionParser::InvalidArgument, /bogus/)
    end

    it "answers metadata create (short)" do
      parser.call %w[-m create]
      expect(configuration.action_metadata).to eq(:create)
    end

    it "answers metadata create (long)" do
      parser.call %w[--metadata create]
      expect(configuration.action_metadata).to eq(:create)
    end

    it "answers metadata delete (short)" do
      parser.call %w[-m delete]
      expect(configuration.action_metadata).to eq(:delete)
    end

    it "answers metadata delete (long)" do
      parser.call %w[--metadata delete]
      expect(configuration.action_metadata).to eq(:delete)
    end

    it "answers metadata recreate (short)" do
      parser.call %w[-m recreate]
      expect(configuration.action_metadata).to eq(:recreate)
    end

    it "answers metadata recreate (long)" do
      parser.call %w[--metadata recreate]
      expect(configuration.action_metadata).to eq(:recreate)
    end

    it "fails with missing metadata action" do
      expectation = proc { parser.call %w[--metadata] }
      expect(&expectation).to raise_error(OptionParser::MissingArgument, /--metadata/)
    end

    it "fails with invalid metadata action" do
      expectation = proc { parser.call %w[--metadata bogus] }
      expect(&expectation).to raise_error(OptionParser::InvalidArgument, /bogus/)
    end

    it "enables snippets (short)" do
      parser.call %w[-s]
      expect(configuration.action_snippets).to eq(true)
    end

    it "enables snippets (long)" do
      parser.call %w[--snippets]
      expect(configuration.action_snippets).to eq(true)
    end

    it "answers snippets ASCII Doc format" do
      parser.call %w[--snippets ascii_doc]
      expect(configuration.snippets_format).to eq(:ascii_doc)
    end

    it "answers snippets Markdown format" do
      parser.call %w[--snippets markdown]
      expect(configuration.snippets_format).to eq(:markdown)
    end

    it "answers snippets default format when no format is given" do
      parser.call %w[--snippets]
      expect(configuration.snippets_format).to eq(:markdown)
    end

    it "fails with invalid snippets action" do
      expectation = proc { parser.call %w[--snippets bogus] }
      expect(&expectation).to raise_error(OptionParser::InvalidArgument, /bogus/)
    end

    it "answers session rebuild (short)" do
      parser.call %w[-S]
      expect(configuration.action_session).to eq(true)
    end

    it "answers session rebuild (long)" do
      parser.call %w[--session]
      expect(configuration.action_session).to eq(true)
    end

    it "answers update (short)" do
      parser.call %w[-u]
      expect(configuration.action_update).to eq(true)
    end

    it "answers update (long)" do
      parser.call %w[--update]
      expect(configuration.action_update).to eq(true)
    end

    it "answers version (short)" do
      parser.call %w[-v]
      expect(configuration.action_version).to match(/Sublime Text Kit\s\d+\.\d+\.\d+/)
    end

    it "answers version (long)" do
      parser.call %w[--version]
      expect(configuration.action_version).to match(/Sublime Text Kit\s\d+\.\d+\.\d+/)
    end

    it "enables help (short)" do
      parser.call %w[-h]
      expect(configuration.action_help).to eq(true)
    end

    it "enables help (long)" do
      parser.call %w[--help]
      expect(configuration.action_help).to eq(true)
    end
  end
end
