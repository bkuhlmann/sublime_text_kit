$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "sublime_text_kit/identity"

Gem::Specification.new do |spec|
  spec.name                  = SublimeTextKit::Identity.name
  spec.version               = SublimeTextKit::Identity.version
  spec.platform              = Gem::Platform::RUBY
  spec.authors               = ["Brooke Kuhlmann"]
  spec.email                 = ["brooke@alchemists.io"]
  spec.homepage              = "https://github.com/bkuhlmann/sublime_text_kit"
  spec.summary               = "A command line interface for managing Sublime Text metadata."
  spec.description           = "A command line interface for managing Sublime Text metadata."
  spec.license               = "MIT"

  if ENV["RUBY_GEM_SECURITY"] == "enabled"
    spec.signing_key = File.expand_path("~/.ssh/gem-private.pem")
    spec.cert_chain = [File.expand_path("~/.ssh/gem-public.pem")]
  end

  spec.required_ruby_version = "~> 2.3"
  spec.add_dependency "thor", "~> 0.19"
  spec.add_dependency "thor_plus", "~> 3.1"
  spec.add_dependency "multi_json", "~> 1.12"
  spec.add_development_dependency "rake", "~> 11.0"
  spec.add_development_dependency "gemsmith", "~> 7.6"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "pry-state"
  spec.add_development_dependency "bond"
  spec.add_development_dependency "wirb"
  spec.add_development_dependency "hirb"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "rb-fsevent" # Guard file events for OSX.
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "terminal-notifier"
  spec.add_development_dependency "terminal-notifier-guard"
  spec.add_development_dependency "rubocop", "~> 0.40"
  spec.add_development_dependency "codeclimate-test-reporter"

  spec.files            = Dir["lib/**/*", "vendor/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.executables << "stk"
  spec.require_paths = ["lib"]
end
