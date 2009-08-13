module RspecSequel
  module Matchers

    class ValidateNumericMatcher < RspecSequel::Validation
      def description
        desc = "validate that #{@attribute.inspect} is a valid float"
        desc << " with option(s) #{hash_to_nice_string @options}" unless @options.empty?
        desc
      end

      def validation_type
        :validates_numeric
      end
    end

    def validate_numeric(*args)
      ValidateNumericMatcher.new(*args)
    end

  end
end