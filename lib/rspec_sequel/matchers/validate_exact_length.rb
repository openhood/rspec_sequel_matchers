module RspecSequel
  module Matchers

    class ValidateExactLengthMatcher < RspecSequel::Validation
      def description
        desc = "validate exact length of #{@attribute.inspect} to #{@additionnal.inspect}"
        desc << " with #{hash_to_nice_string @options}" unless @options.empty?
        desc
      end

      def additionnal_param_type
        Fixnum
      end

      def validation_type
        :validates_exact_length
      end
    end

    def validate_exact_length(*args)
      ValidateExactLengthMatcher.new(*args)
    end

  end
end