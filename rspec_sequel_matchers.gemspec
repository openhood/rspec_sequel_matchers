# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rspec_sequel_matchers"
  s.version = "0.3.0"

  s.summary = %q{RSpec Matchers for Sequel}
  s.homepage = %q{http://github.com/openhood/rspec_sequel_matchers}

  s.authors = ["Jonathan Tron", "Joseph Halter"]
  s.date = %q{2010-03-02}
  s.email = %q{team@openhood.com}
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = Dir.glob("{lib,spec}/**/*") + %w(README.rdoc)
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]

  s.add_runtime_dependency "sequel", ">= 3.8.0"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
