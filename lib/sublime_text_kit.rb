# frozen_string_literal: true

require "zeitwerk"

Zeitwerk::Loader.new.then do |loader|
  loader.inflector.inflect "ascii_doc" => "ASCIIDoc", "cli" => "CLI"
  loader.tag = File.basename __FILE__, ".rb"
  loader.push_dir __dir__
  loader.setup
end

# Main namespace.
module SublimeTextKit
  def self.loader(registry = Zeitwerk::Registry) = registry.loader_for __FILE__
end
