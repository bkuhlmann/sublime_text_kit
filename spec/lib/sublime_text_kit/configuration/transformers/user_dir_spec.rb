# frozen_string_literal: true

require "spec_helper"

RSpec.describe SublimeTextKit::Configuration::Transformers::UserDir do
  include Dry::Monads[:result]

  subject(:transformer) { described_class.new }

  describe "#call" do
    it "answers transformed content when home path exists" do
      expect(transformer.call({home: "/home"})).to eq(
        Success(
          home: "/home",
          user_dir: Pathname("/home/Library/Application Support/Sublime Text/Packages/User")
        )
      )
    end

    it "answers original content when home path doesn't exist" do
      expect(transformer.call({})).to eq(Success({}))
    end
  end
end
