# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'namarara/version'

Gem::Specification.new do |spec|
  spec.name          = 'namarara'
  spec.version       = Namarara::VERSION
  spec.authors       = ['Brendon Torre', 'Glenn Y. Rolland']
  spec.email         = ['glenux@glenux.net']

  spec.summary       = 'A library and tools for parsing boolean expressions'
  spec.description   = "A library and tools for parsing boolean expressions.
  It could be especially useful in the case you want, in a program, to allow
  users define they own set of blocking/passing rules or conditions based on a
  given set of variables."
  spec.homepage      = 'https://github.com/glenux/namarara/'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the
  # 'allowed_push_host' to allow pushing to a single host or delete this
  # section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'minitest', '~> 5.0'
  # spec.add_development_dependency 'opal'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rly', '~> 0.2.3'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'sinatra', '~> 2.0.8.1'
  spec.add_development_dependency 'thor', '~> 1.0.1'

end
