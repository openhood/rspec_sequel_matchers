require "rubygems"
require "rspec"
require "sequel"
require "sequel/extensions/inflector"
require "sequel/extensions/migration"
require "rspec_sequel_matchers"

def jruby?
  (defined?(RUBY_ENGINE) && RUBY_ENGINE == 'jruby') || defined?(JRUBY_VERSION)
end

# connect to an in-memory database
begin
  if jruby?
    Sequel.connect "jdbc:sqlite::memory:"
  else
    Sequel.sqlite
  end
rescue Sequel::AdapterNotFound
  puts "sqlite not available."
  exit 1 # failure
end

# drop all tables and migrate on start
db = Sequel::Model.db
db.tables.each do |table_name|
  db.drop_table table_name
end
Sequel::Migrator.apply(db, File.join(File.dirname(__FILE__), "migrations"))

module RspecHelpers
  def define_model(model, &block)
    model_name = model.to_s.camelize.to_sym
    table_name = model.to_s.tableize.to_sym
    @defined_models ||= []
    @defined_models << model_name
    klass = Object.const_set model_name, Sequel::Model(table_name)
    klass.class_eval &block if block_given?
  end
end

RSpec.configure do |c|
  c.mock_framework = :rspec
  c.include(RspecHelpers)
  c.include(RspecSequel::Matchers)
  # undefine models defined via define_model (if any)
  # truncate all tables between each spec
  c.after(:each) do
    db = Sequel::Model.db
    db.tables.each do |table_name|
      db["TRUNCATE #{table_name}"]
    end
    (@defined_models||[]).each do |model_name|
      Object.send(:remove_const, model_name)
    end
    @defined_models = nil
  end
end
