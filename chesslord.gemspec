lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'chesslord/version'

Gem::Specification.new do |spec|
  spec.name          = 'chesslord'
  spec.version       = Chesslord::VERSION
  spec.authors       = ['Deyan Dobrinov']
  spec.email         = ['deyan.dobrinov@gmail.com']
  spec.summary       = 'Chess based strategy game'
  spec.homepage      = 'https://github.com/dobrinov/chesslord'
  spec.files         = `git ls-files -z`.split("\x0")
  spec.license       = 'Nonstandard'
  spec.require_paths = ['lib']

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 3.5'
end
