$:.push File.expand_path("../lib", __FILE__)
require "sublime_text_kit/version"

Gem::Specification.new do |spec|
  spec.name                  = "sublime_text_kit"
  spec.version               = SublimeTextKit::VERSION
  spec.platform              = Gem::Platform::RUBY
  spec.authors               = ["Brooke Kuhlmann"]
  spec.email                 = ["bkuhlmann@alchemists.io"]
  spec.homepage              = "https://github.com/bkuhlmann/sublime_text_kit"
  spec.summary               = "Command line utilities for Sublime Text."
  spec.description           = "Command line utilities for Sublime Text packaged as a Ruby Gem."
  spec.license               = "MIT"

  unless ENV["CI"] == "true"
    spec.signing_key = File.expand_path("~/.ssh/gem-private.pem")
    spec.cert_chain = [File.expand_path("~/.ssh/gem-public.pem")]
  end

  case Gem.ruby_engine
    when "ruby"
      spec.add_development_dependency "pry-byebug"
      spec.add_development_dependency "pry-stack_explorer"
    when "jruby"
      spec.add_development_dependency "pry-nav"
    when "rbx"
      spec.add_development_dependency "pry-nav"
      spec.add_development_dependency "pry-stack_explorer"
    else
      raise RuntimeError.new("Unsupported Ruby Engine!")
  end

  spec.add_dependency "thor", "~> 0.19"
  spec.add_dependency "thor_plus", "~> 1.7"
  spec.add_dependency "multi_json", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-remote"
  spec.add_development_dependency "pry-rescue"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rb-fsevent" # Guard file events for OSX.
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "terminal-notifier-guard"
  spec.add_development_dependency "codeclimate-test-reporter"

  spec.files            = Dir["lib/**/*", "vendor/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.executables      << "stk"
  spec.require_paths    = ["lib"]
end
