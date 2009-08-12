# Load base
["base", "association", "validation"].each do |file|
  require File.join(File.dirname(__FILE__), "rspec_sequel", file)
end

# Add matchers
Dir[File.join(File.dirname(__FILE__), "rspec_sequel", "matchers", "*.rb")].each do |file|
  require file
end