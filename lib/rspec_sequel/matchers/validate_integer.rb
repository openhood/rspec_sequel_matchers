module RspecSequel
  module Matchers

    class ValidateIntegerMatcher < RspecSequel::Validation
      def description
        desc = "validate that #{@attribute.inspect} is a valid Integer"
        desc << " with option(s) #{hash_to_nice_string @options}" unless @options.empty?
        desc
      end

      def validation_type
        :validates_integer
      end
    end

    def validate_integer(*args)
      ValidateIntegerMatcher.new(*args)
    end

  end
end