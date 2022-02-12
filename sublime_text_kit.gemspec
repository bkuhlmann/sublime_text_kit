# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "sublime_text_kit"
  spec.version = "12.2.0"
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://www.alchemists.io/projects/sublime_text_kit"
  spec.summary = "A command line interface for managing Sublime Text metadata."
  spec.license = "Hippocratic-3.0"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/sublime_text_kit/issues",
    "changelog_uri" => "https://www.alchemists.io/projects/sublime_text_kit/versions",
    "documentation_uri" => "https://www.alchemists.io/projects/sublime_text_kit",
    "label" => "Sublime Text Kit",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/sublime_text_kit"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.1"
  spec.add_dependency "dry-container", "~> 0.8"
  spec.add_dependency "pastel", "~> 0.8"
  spec.add_dependency "refinements", "~> 9.2"
  spec.add_dependency "runcom", "~> 8.2"
  spec.add_dependency "spek", "~> 0.0"
  spec.add_dependency "zeitwerk", "~> 2.5"

  spec.bindir = "exe"
  spec.executables << "sublime_text_kit"
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.files = Dir["*.gemspec", "lib/**/*"]
end
