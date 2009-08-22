require "rubygems"
require "rake"

begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name = "rspec_sequel_matchers"
    gem.summary = %Q{TODO}
    gem.email = "team@openhood.com"
    gem.homepage = "http://github.com/openhood/rspec_sequel_matchers"
    gem.authors = ["Jonathan Tron", "Joseph Halter"]
    gem.add_dependency "rspec", "~> 1.2.3"
    gem.add_dependency "sequel", ">= 3.1.0"

    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require "spec/rake/spectask"
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << "lib" << "spec"
  spec.spec_files = FileList["spec/**/*_spec.rb"]
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << "lib" << "spec"
  spec.pattern = "spec/**/*_spec.rb"
  spec.rcov = true
end

task :default => :spec

require "rake/rdoctask"
Rake::RDocTask.new do |rdoc|
  if File.exist?("VERSION.yml")
    config = YAML.load(File.read("VERSION.yml"))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = "rdoc"
  rdoc.title = "test #{version}"
  rdoc.rdoc_files.include("README*")
  rdoc.rdoc_files.include("lib/**/*.rb")
end
