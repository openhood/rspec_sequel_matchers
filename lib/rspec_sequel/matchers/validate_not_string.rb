module RspecSequel
  module Matchers

    class ValidateNotStringMatcher < RspecSequel::Validation
      def description
        desc = "validate that #{@attribute.inspect} is not a string"
        desc << " with option(s) #{hash_to_nice_string @options}" unless @options.empty?
        desc
      end

      def validation_type
        :validates_not_string
      end
    end

    def validate_not_string(*args)
      ValidateNotStringMatcher.new(*args)
    end

  end
end