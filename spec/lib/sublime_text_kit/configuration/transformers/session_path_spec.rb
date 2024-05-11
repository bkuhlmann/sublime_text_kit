# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Configuration::Transformers::SessionPath do
  include Dry::Monads[:result]

  subject(:transformer) { described_class.new }

  describe "#call" do
    it "answers transformed attributes when home path exists" do
      expect(transformer.call({home: "/home"})).to eq(
        Success(
          home: "/home",
          session_path: Pathname(
            "/home/Library/Application Support/Sublime Text/Local/Session.sublime_session"
          )
        )
      )
    end

    it "answers original attributes when home path doesn't exist" do
      expect(transformer.call({})).to eq(Success({}))
    end
  end
end
