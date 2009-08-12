module RspecSequel
  module Matchers

    class HaveOneToManyMatcher < RspecSequel::Association
      def association_type
        :one_to_many
      end
      
      def valid?(db, i, c, attribute, options)
        matching = super

        # check that association model exists, etc.
        matching
      end
    end

    def have_one_to_many(*args)
      HaveOneToManyMatcher.new(*args)
    end

  end
end