# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::CLI::Actions::Config do
  subject(:action) { described_class.new }

  include_context "with application dependencies"

  describe "#call" do
    it "edits configuration" do
      action.call :edit
      expect(kernel).to have_received(:system).with(include("EDITOR"))
    end

    it "views configuration" do
      action.call :view
      expect(kernel).to have_received(:system).with(include("cat"))
    end

    it "logs error with invalid action" do
      action.call :bogus
      expect(logger.reread).to match(/🛑.+Invalid configuration action: bogus./)
    end
  end
end
