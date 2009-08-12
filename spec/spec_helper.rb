require "spec"
require "rubygems"
require "sequel"
require "sequel/extensions/migration"
require File.join(File.dirname(__FILE__), "..", "lib", "rspec_sequel_matchers")

# connect to an in-memory database
begin
  Sequel.sqlite
rescue Sequel::AdapterNotFound
  puts "sqlite not available. Install it with: sudo gem install sqlite3-ruby"
end

Spec::Runner.configure do |config|
  config.include(RspecSequel::Matchers)
  
  # drop all tables and migrate before first spec
  config.before(:all) do
    db = Sequel::Model.db
    db.tables.each do |table_name|
      db.drop_table table_name
    end
    Sequel::Migrator.apply(db, File.join(File.dirname(__FILE__), "migrations"))
  end

  # truncate all tables between each spec
  config.after(:each) do
    db = Sequel::Model.db
    db.tables.each do |table_name|
      db["TRUNCATE #{table_name}"]
    end
  end

end