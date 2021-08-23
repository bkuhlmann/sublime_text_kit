# frozen_string_literal: true

require "zeitwerk"

Zeitwerk::Loader.for_gem
                .then do |loader|
                  loader.inflector.inflect "ascii_doc" => "ASCIIDoc", "cli" => "CLI"
                  loader.setup
                end

# Main namespace.
module SublimeTextKit
end
