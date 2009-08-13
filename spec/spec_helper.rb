require "spec"
require "rubygems"
require "sequel"
require "sequel/extensions/inflector"
require "sequel/extensions/migration"
require File.join(File.dirname(__FILE__), "..", "lib", "rspec_sequel_matchers")

# connect to an in-memory database
begin
  Sequel.sqlite
rescue Sequel::AdapterNotFound
  puts "sqlite not available. Install it with: sudo gem install sqlite3-ruby"
end

def define_model(model, &block)
  model_name = model.to_s.camelize.to_sym
  table_name = model.to_s.tableize.to_sym
  @defined_models ||= []
  @defined_models << model_name
  klass = Object.const_set model_name, Sequel::Model(table_name)
  klass.class_eval &block if block_given?
end

def undefine_models
  @defined_models.each{|model_name|
    Object.send(:remove_const, model_name)
  }
  @defined_models = []
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

  # undefine models defined via define_model
  config.after(:all) do
    undefine_models
  end

end