module RspecSequel
  module Matchers

    class ValidateIncludesMatcher < RspecSequel::Validation
      def description
        desc = "validate that #{@attribute.inspect} is included in #{@additionnal.inspect}"
        desc << " with option(s) #{hash_to_nice_string @options}" unless @options.empty?
        desc
      end

      def additionnal_param_type
        Enumerable
      end

      def validation_type
        :validates_includes
      end
    end

    def validate_includes(*args)
      ValidateIncludesMatcher.new(*args)
    end

  end
end