module RspecSequel
  module Matchers

    class HaveManyThroughManyMatcher < RspecSequel::Association
      def association_type
        :many_through_many
      end

      def valid?(db, i, c, attribute, options)
        matching = super

        # check that association model exists, etc.
        matching
      end
    end

    def have_many_through_many(*args)
      HaveManyThroughManyMatcher.new(*args)
    end

  end
end
