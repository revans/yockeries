# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "yockeries"
  gem.version       = '0.0.1'
  gem.authors       = ["Robert Evans"]
  gem.email         = ["robert@codewranglers.org"]
  gem.description   = %q{Use Ruby Fixtures to create mocks or use in place of factories to create objects}
  gem.summary       = %q{Use Ruby Fixtures to create mocks or use in place of factories to create objects}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
