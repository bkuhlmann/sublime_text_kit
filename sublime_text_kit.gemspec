# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "sublime_text_kit"
  spec.version = "18.2.1"
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://alchemists.io/projects/sublime_text_kit"
  spec.summary = "A command line interface for managing Sublime Text metadata."
  spec.license = "Hippocratic-2.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/sublime_text_kit/issues",
    "changelog_uri" => "https://alchemists.io/projects/sublime_text_kit/versions",
    "homepage_uri" => "https://alchemists.io/projects/sublime_text_kit",
    "funding_uri" => "https://github.com/sponsors/bkuhlmann",
    "label" => "Sublime Text Kit",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/sublime_text_kit"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.4"
  spec.add_dependency "cogger", "~> 1.0"
  spec.add_dependency "containable", "~> 1.1"
  spec.add_dependency "dry-monads", "~> 1.9"
  spec.add_dependency "dry-schema", "~> 1.13"
  spec.add_dependency "etcher", "~> 3.0"
  spec.add_dependency "infusible", "~> 4.0"
  spec.add_dependency "refinements", "~> 13.3"
  spec.add_dependency "runcom", "~> 12.0"
  spec.add_dependency "sod", "~> 1.0"
  spec.add_dependency "spek", "~> 4.0"
  spec.add_dependency "zeitwerk", "~> 2.7"

  spec.bindir = "exe"
  spec.executables << "sublime_text_kit"
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.files = Dir["*.gemspec", "lib/**/*"]
end
