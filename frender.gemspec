$: << File.expand_path("../lib", __FILE__)

require 'frender/version'

Gem::Specification::new do |spec|
  spec.name = "frender"
  spec.version = Frender::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.summary = "frender"
  spec.description = "description: Renders config files from input data in YAML format using a variety of template languages"
  spec.licenses = ["Apache-2"]

  spec.files = Dir["lib/**/*.rb", "bin/**/*", "Gemfile", "Gemfile.lock"]
  spec.executables = []

  spec.require_path = "lib"

  spec.has_rdoc = false
  spec.test_files = nil

  spec.bindir = 'bin'

  spec.add_dependency 'tilt', '~> 2.0'
  spec.add_dependency 'methadone', '~> 1.8'

  spec.extensions.push(*[])

  spec.author = "R.I.Pienaar"
  spec.email = "rip@devco.net"
  spec.homepage = "http://devco.net/"
end
