module RspecSequel
  module Matchers

    class ValidateFormatMatcher < RspecSequel::Validation
      def description
        desc = "validate format of #{@attribute.inspect} with #{@additionnal.inspect}"
        desc << " and option(s) #{hash_to_nice_string @options}" unless @options.empty?
        desc
      end

      def additionnal_param_type
        Regexp
      end

      def validation_type
        :validates_format
      end
    end

    def validate_format(*args)
      ValidateFormatMatcher.new(*args)
    end

  end
end