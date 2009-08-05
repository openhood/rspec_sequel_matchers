# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rspec_sequel_matchers}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jonathan Tron", "Joseph Halter"]
  s.date = %q{2009-08-05}
  s.email = %q{jonathan@tron.name}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/rspec_sequel/base.rb",
     "lib/rspec_sequel/matchers/have_column.rb",
     "lib/rspec_sequel/matchers/validate_presence.rb",
     "lib/rspec_sequel_matchers.rb",
     "rspec_sequel_matchers.gemspec",
     "spec/have_column_matcher_spec.rb",
     "spec/migrations/001_create_items.rb",
     "spec/spec_helper.rb",
     "spec/validate_presence_matcher_spec.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/JonathanTron/rspec_sequel_matchers}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}
  s.test_files = [
    "spec/have_column_matcher_spec.rb",
     "spec/migrations/001_create_items.rb",
     "spec/spec_helper.rb",
     "spec/validate_presence_matcher_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec>, [">= 0"])
      s.add_runtime_dependency(%q<sequel>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<sequel>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<sequel>, [">= 0"])
  end
end
