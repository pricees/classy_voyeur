# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'classy_voyeur/version'

Gem::Specification.new do |gem|
  gem.name          = "classy_voyeur"
  gem.version       = ClassyVoyeur::VERSION
  gem.authors       = ["Edward Price"]
  gem.email         = ["ted.price@gmail.com"]
  gem.description   = %q{View object space, internals, memory of rack app}
  gem.summary       = %q{View object space, internals, memory of rack app}
  gem.homepage      = "https://github.com/pricees/classy_voyeur"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
