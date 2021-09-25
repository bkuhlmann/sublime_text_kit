# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Actions::Session do
  subject(:action) { described_class.new rebuilder: rebuilder }

  include_context "with application container"

  let(:rebuilder) { instance_spy SublimeTextKit::Sessions::Rebuilder }

  describe "#call" do
    it "rebuilds session" do
      action.call
      expect(rebuilder).to have_received(:call)
    end

    it "logs session was rebuilt" do
      expectation = proc { action.call }
      expect(&expectation).to output("Session rebuilt.\n").to_stdout
    end
  end
end
