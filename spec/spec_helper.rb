require "spec"
require "rubygems"
require "sequel"
require "sequel/extensions/migration"

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "rspec_sequel_matchers"

# connect to an in-memory database
begin
  Sequel.sqlite
rescue Sequel::AdapterNotFound
  puts "sqlite not available. Install it with: sudo gem install sqlite3-ruby"
end

Spec::Runner.configure do |config|
  config.include(RspecSequel::Matchers)
  
  config.before(:all) do
    DB = Sequel::Model.db
    DB.tables.each do |table_name|
      DB["DROP #{table_name}"]
    end
    Sequel::Migrator.apply(DB, File.join(File.dirname(__FILE__), "migrations"))
  end

  config.after(:each) do
    DB = Sequel::Model.db
    DB.tables.each do |table_name|
      DB["TRUNCATE #{table_name}"]
    end
  end

end