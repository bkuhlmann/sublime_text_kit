# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Actions::Session do
  using Refinements::StringIOs

  subject(:action) { described_class.new rebuilder: }

  include_context "with application container"

  let(:rebuilder) { instance_spy SublimeTextKit::Sessions::Rebuilder }

  describe "#call" do
    it "rebuilds session" do
      action.call
      expect(rebuilder).to have_received(:call)
    end

    it "logs session was rebuilt" do
      action.call
      expect(io.reread).to eq("Session rebuilt.\n")
    end
  end
end
