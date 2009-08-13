module RspecSequel
  module Matchers

    class ValidateMinLengthMatcher < RspecSequel::Validation
      def description
        desc = "validate length of #{@attribute.inspect} is greater than or equal to #{@additionnal.inspect}"
        desc << " with option(s) #{hash_to_nice_string @options}" unless @options.empty?
        desc
      end

      def additionnal_param_type
        Fixnum
      end

      def validation_type
        :validates_min_length
      end
    end

    def validate_min_length(*args)
      ValidateMinLengthMatcher.new(*args)
    end

  end
end