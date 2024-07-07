# frozen_string_literal: true

require "cogger"
require "containable"
require "etcher"
require "runcom"
require "spek"

module SublimeTextKit
  # Provides a global gem container for injection into other objects.
  module Container
    extend Containable

    register :registry do
      Etcher::Registry.new(contract: Configuration::Contract, model: Configuration::Model)
                      .add_loader(:yaml, self[:defaults_path])
                      .add_loader(:environment, only: %w[HOME])
                      .add_loader(:yaml, self[:xdg_config].active)
                      .add_transformer(
                        :root,
                        :session_path,
                        fallback: "~/Library/Application Support/Sublime Text/Local" \
                                  "/Session.sublime_session"
                      )
                      .add_transformer(
                        :root,
                        :user_dir,
                        fallback: "~/Library/Application Support/Sublime Text/Packages/User"
                      )
    end

    register(:settings) { Etcher.call(self[:registry]).dup }
    register(:specification) { Spek::Loader.call "#{__dir__}/../../sublime_text_kit.gemspec" }
    register(:defaults_path) { Pathname(__dir__).join("configuration/defaults.yml") }
    register(:xdg_config) { Runcom::Config.new "sublime_text_kit/configuration.yml" }
    register(:logger) { Cogger.new id: :sublime_text_kit }
    register :io, STDOUT
  end
end
