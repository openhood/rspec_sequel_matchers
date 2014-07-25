require "sequel"
require "sequel/extensions/inflector"
require "rspec/mocks"
require "rspec/mocks/example_methods"

module RspecSequel

  class Base
    include RSpec::Mocks::ExampleMethods

    def initialize(attribute, options={})
      raise ArgumentError, "not enough params for matcher, required attribute is missing" if attribute.nil?
      @attribute = attribute
      @options = options
      @description = []
    end

    def matches?(target)
      @suffix = []
      if target.is_a?(Sequel::Model)
        @prefix = "expected #{target.inspect} to"
        valid?(target.db, target, target.class, @attribute, @options)
      else
        @prefix = "expected #{target.table_name.to_s.classify} to"
        valid?(target.db, target.new, target, @attribute, @options)
      end
    end

    def failure_message
      [@prefix, description, @suffix].flatten.compact.join(" ")
    end

    def failure_message_when_negated
      [@prefix, "not", description, @suffix].flatten.compact.join(" ")
    end

    def hash_to_nice_string(hash)
      hash.sort{|a,b| a[0].to_s<=>b[0].to_s}.collect{|param| param.collect{|v| v.inspect}.join(" => ")}.join(", ")
    end
  end

end
