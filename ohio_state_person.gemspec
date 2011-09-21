# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ohio_state_person/version"

Gem::Specification.new do |s|
  s.name        = "ohio_state_person"
  s.version     = OhioStatePerson::VERSION
  s.authors     = ["mikegee"]
  s.email       = ["gee.24@osu.edu"]
  s.homepage    = "https://github.com/ASCTech/ohio_state_person"
  s.summary     = %q{ActiveRecord mixin for people at Ohio State University}
  s.description = %q{requires fields: name_n, emplid; sets id to emplid.to_i; provides a search method; etc.}

  s.rubyforge_project = "ohio_state_person"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "activerecord", '~> 3.0'
end
