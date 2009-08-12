module RspecSequel
  module Matchers

    class HaveManyToManyMatcher < RspecSequel::Association
      def association_type
        :many_to_many
      end
      
      def valid?(db, i, c, attribute, options)
        matching = super

        # check that association model exists, etc.
        matching
      end
    end

    def have_many_to_many(*args)
      HaveManyToManyMatcher.new(*args)
    end

  end
end