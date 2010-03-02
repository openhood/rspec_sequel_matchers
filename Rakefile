require "rubygems"
require "rake"

begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.version = "0.2.0"
    gem.name = "rspec_sequel_matchers"
    gem.summary = %Q{RSpec Matchers for Sequel}
    gem.email = "team@openhood.com"
    gem.homepage = "http://github.com/openhood/rspec_sequel_matchers"
    gem.authors = ["Jonathan Tron", "Joseph Halter"]
    gem.add_dependency "rspec", ">= 2.0.0.a"
    gem.add_dependency "sequel", ">= 3.8.0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require "rspec/core/rake_task"
Rspec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

Rspec::Core::RakeTask.new(:rcov) do |spec|
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
