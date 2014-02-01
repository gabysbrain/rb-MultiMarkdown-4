# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'multimarkdown/version'

Gem::Specification.new do |spec|
  spec.name          = "multimarkdown"
  spec.version       = Multimarkdown::VERSION
  spec.authors       = ["Thomas Torsney-Weir"]
  spec.email         = ["torsneyt@gmail.com"]
  spec.description   = <<-EOF 
                       A Ruby extension that can process MultiMarkdown-formatted
                       text using the multimarkdown command line tool.
                       EOF
  spec.summary       = %q{An interface to the multimarkdown command line tool}
  spec.homepage      = "https://github.com/gabysbrain/rb-MultiMarkdown-4"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
