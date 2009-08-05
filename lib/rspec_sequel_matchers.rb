# Load base
require File.join(File.dirname(__FILE__), "rspec_sequel", "base")

# Add matchers
Dir[File.join(File.dirname(__FILE__), "rspec_sequel", "matchers", "*.rb")].each do |file|
  require file
end