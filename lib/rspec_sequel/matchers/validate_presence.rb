module RspecSequel
  module Matchers

    class ValidatePresenceMatcher < RspecSequel::Validation
      def description
        desc = "validate presence of #{@attribute.inspect}"
        desc << " with #{hash_to_nice_string @options}" unless @options.empty?
        desc
      end

      def valid?(db, i, c, attribute, options)
        if matching = super
          called_count = 0
          i = i.dup
          i.stub!(:validates_presence).and_return{|*args|
            called_options = args.last.is_a?(Hash) ? args.pop : {};
            if args.include?(attribute)
              if options.empty?
                called_count += 1
              else
                @suffix << "but called with #{hash_to_nice_string called_options} instead"
                called_count +=1 if called_options==options
              end
            end
          }
          i.valid?
          matching = called_count==1
        end
        matching
      end
    end

    def validate_presence(*args)
      ValidatePresenceMatcher.new(*args)
    end

  end
end