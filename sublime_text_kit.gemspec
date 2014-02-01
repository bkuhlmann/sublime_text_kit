$:.push File.expand_path("../lib", __FILE__)
require "sublime_text_kit/version"

def add_security_key specification, method, files
  file = files.is_a?(Array) ? files.first : files
  if File.exists? file
    specification.send "#{method}=", files
  else
    puts "WARNING: Security key not found for #{specification.name} gem specification: #{file}"
  end
end

Gem::Specification.new do |s|
  s.name									= "sublime_text_kit"
  s.version								= SublimeTextKit::VERSION
  s.platform							= Gem::Platform::RUBY
  s.author								= "Brooke Kuhlmann"
  s.email									= "brooke@redalchemist.com"
  s.homepage							= "https://github.com/bkuhlmann/sublime_text_kit"
  s.summary								= "Command line utilities for Sublime Text."
  s.description						= "Command line utilities for Sublime Text packaged as a Ruby Gem."
	s.license								= "MIT"

  add_security_key s, "signing_key", File.expand_path("~/.ssh/gem-private.pem")
  add_security_key s, "cert_chain", [File.expand_path("~/.ssh/gem-public.pem")]

	s.required_ruby_version = "~> 2.0"
  s.add_dependency "thor", "~> 0.18"
  s.add_dependency "thor_plus", "~> 1.0"
  s.add_dependency "oj", "~> 2.5"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "pry"
  s.add_development_dependency "pry-byebug"
  s.add_development_dependency "pry-remote"
  s.add_development_dependency "pry-rescue"
  s.add_development_dependency "pry-stack_explorer"
  s.add_development_dependency "pry-vterm_aliases"
  s.add_development_dependency "pry-git"
  s.add_development_dependency "pry-doc"
  s.add_development_dependency "rspec"
  s.add_development_dependency "aruba"
  s.add_development_dependency "rb-fsevent" # Guard file events for OSX.
  s.add_development_dependency "guard-rspec"

  s.files            = Dir["lib/**/*", "vendor/**/*"]
  s.extra_rdoc_files = Dir["README*", "LICENSE*"]
	s.executables      << "stk"
  s.require_paths    = ["lib"]
end