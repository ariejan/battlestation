# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "battlestation/version"

Gem::Specification.new do |s|
  s.name        = "battlestation"
  s.version     = Battlestation::VERSION
  s.authors     = ["Ariejan de Vroom"]
  s.email       = ["ariejan@ariejan.net"]
  s.homepage    = ""
  s.summary     = %q{Get your battle station up and running fast}
  s.description = %q{Get your battle station up and running fast}

  s.rubyforge_project = "battlestation"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
