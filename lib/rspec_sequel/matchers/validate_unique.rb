module RspecSequel
  module Matchers

    class ValidateUniqueMatcher < RspecSequel::Validation
      def description
        desc = "validate uniqueness of #{@attribute.inspect}"
        desc << " with option(s) #{hash_to_nice_string @options}" unless @options.empty?
        desc
      end

      def validation_type
        :validates_unique
      end

      def valid_options
        [:message]
      end

      def args_to_called_attributes(args)
        called_attributes = []
        until args.empty?
          called_attributes << args.shift
        end
        called_attributes
      end
    end

    def validate_unique(*args)
      ValidateUniqueMatcher.new(*args)
    end

  end
end