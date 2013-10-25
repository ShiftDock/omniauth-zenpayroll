# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth-zenpayroll/version"

Gem::Specification.new do |s|
  s.name        = "omniauth-zenpayroll"
  s.version     = OmniAuth::ZenPayroll::VERSION
  s.authors     = ["John M. Hope"]
  s.email       = ["john@shiftdock.com"]
  s.homepage    = "https://github.com/shiftdock/omniauth-zenpayroll"
  s.summary     = %q{OmniAuth strategy for ZenPayroll}
  s.description = %q{OmniAuth strategy for ZenPayroll}
  s.license     = "MIT"

  s.rubyforge_project = "omniauth-zenpayroll"

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'multi_json', '~> 1.3'
  s.add_runtime_dependency 'omniauth-oauth2', '~> 1.1.1'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'webmock'
end