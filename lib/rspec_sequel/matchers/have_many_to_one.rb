module RspecSequel
  module Matchers

    class HaveManyToOneMatcher < RspecSequel::Base

      def description
        desc = "have a many_to_one association #{@attribute.inspect}"
        desc << " with #{hash_to_nice_string @options}" unless @options.empty?
        desc
      end

      def valid?(db, i, c, attribute, options)

        # expected association
        expected = options.dup
        expected[:type] = :many_to_one

        # get actual association using reflection
        found = c.association_reflection(attribute) || {}
        if found.empty?
          @suffix << "(no association #{@attribute.inspect} found)"
          false
        else
          matching = found[:type] == :many_to_one
          options.each{|key, value|
            if found[key]!=value
              @suffix << "expected #{key.inspect} == #{value.inspect} but found #{found[key].inspect} instead"
              matching = false
            end
          }
          matching
        end
      end

    end

    def have_many_to_one(*args)
      HaveManyToOneMatcher.new(*args)
    end

  end
end