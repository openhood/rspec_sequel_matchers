module RspecSequel

  class Validation < Base

    def initialize(*args)
      # initialize Base
      options = args.last.is_a?(Hash) ? args.pop : {}
      super(args.pop, options)

      # check additionnal param
      if additionnal_param_required?
        if args.empty?
          raise ArgumentError, "not enough params for matcher, required #{additionnal_param_type.inspect} parameter is missing"
        elsif args.size>1
          raise ArgumentError, "too many params for matcher"
        else
          @additionnal = args.pop
          raise ArgumentError, "invalid first parameter, expected #{additionnal_param_type.inspect} received #{@additionnal.class.inspect}" unless @additionnal.kind_of?(additionnal_param_type)
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
      invalid_options = options.keys.reject{|o| valid_options.include?(o)}
      invalid_options.each{|o|
        @suffix << "but option #{o.inspect} is not valid"
      }
      invalid_options.empty?
    end

  end

end