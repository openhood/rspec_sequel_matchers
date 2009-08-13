module RspecSequel
  module Matchers

    class ValidatePresenceMatcher < RspecSequel::Validation
      def description
        desc = "validate presence of #{@attribute.inspect}"
        desc << " with option(s) #{hash_to_nice_string @options}" unless @options.empty?
        desc
      end

      def validation_type
        :validates_presence
      end
    end

    def validate_presence(*args)
      ValidatePresenceMatcher.new(*args)
    end

  end
end