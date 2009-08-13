module RspecSequel

  class Association < Base

    def description
      desc = "have a #{association_type} association #{@attribute.inspect}"
      desc << " with option(s) #{hash_to_nice_string @options}" unless @options.empty?
      desc
    end

    def valid?(db, i, c, attribute, options)
      @association = c.association_reflection(attribute) || {}
      if @association.empty?
        @suffix << "(no association #{@attribute.inspect} found)"
        false
      else
        matching = @association[:type] == association_type
        options.each{|key, value|
          if @association[key]!=value
            @suffix << "expected #{key.inspect} == #{value.inspect} but found #{@association[key].inspect} instead"
            matching = false
          end
        }
        matching
      end
    end

  end

end