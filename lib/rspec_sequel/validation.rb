module RspecSequel

  class Validation < Base

    def initialize(*args)
      # initialize Base
      options = args.last.is_a?(Hash) ? args.pop : {}
      super(args.pop, options)

      # check additionnal param
      if additionnal_param_required?
        if args.size>1
          raise ArgumentError, "too many params for matcher"
        else
          @additionnal = args.pop
          raise ArgumentError, "expected matcher first parameter to be #{additionnal_param_type.inspect} but received #{@additionnal.class.inspect} instead" unless @additionnal.kind_of?(additionnal_param_type)
        end
      else
        raise ArgumentError, "too many params for matcher" unless args.empty?
      end
    end

    def additionnal_param_type
      NilClass
    end

    def additionnal_param_required?
      additionnal_param_type!=NilClass
    end

    def valid_options
      [:allow_blank, :allow_missing, :allow_nil, :message]
    end

    def valid?(db, i, c, attribute, options)
      # check options
      invalid_options = options.keys.reject{|o| valid_options.include?(o)}
      invalid_options.each{|o|
        @suffix << "but option #{o.inspect} is not valid"
      }
      return false unless invalid_options.empty?

      # check validation itself
      called_count = 0
      i = i.dup
      i.class.columns # ensure colums are read again after .dup
      allow(i).to receive(validation_type) do |*args|
        called_options = args.last.is_a?(Hash) ? args.pop : {}
        called_attributes = args_to_called_attributes(args)
        called_additionnal = args.shift if additionnal_param_required?
        if !args.empty?
          @suffix << "but called with too many params"
        elsif called_attributes.include?(attribute)
          if additionnal_param_required? && @additionnal!=called_additionnal
            @suffix << "but called with #{called_additionnal} instead"
          elsif !options.empty? && called_options!=options
            @suffix << "but called with option(s) #{hash_to_nice_string called_options} instead"
          else
            called_count += 1
          end
        end
      end
      i.valid?
      if called_count>1
        @suffix << "but validation is called too many times"
        return false
      end
      called_count==1
    end

    def args_to_called_attributes(args)
      [args.pop].flatten
    end

  end

end
