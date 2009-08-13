module RspecSequel
  module Matchers

    class ValidateMaxLengthMatcher < RspecSequel::Validation
      def description
        desc = "validate length of #{@attribute.inspect} is less than or equal to #{@additionnal.inspect}"
        desc << " with option(s) #{hash_to_nice_string @options}" unless @options.empty?
        desc
      end

      def additionnal_param_type
        Fixnum
      end

      def validation_type
        :validates_max_length
      end
    end

    def validate_max_length(*args)
      ValidateMaxLengthMatcher.new(*args)
    end

  end
end