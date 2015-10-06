# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'resque_master/version'

Gem::Specification.new do |spec|
  spec.name          = 'resque_master'
  spec.version       = ResqueMaster::VERSION
  spec.authors       = ['Hayden Ball']
  spec.email         = ['hayden@haydenball.me.uk']

  spec.summary       = 'Ship all resque jobs to a master using rabbitmq'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.executables << 'resque-master'

  spec.add_dependency 'bunny'
  spec.add_dependency 'resque'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
end
