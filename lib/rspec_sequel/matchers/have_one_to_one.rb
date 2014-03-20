module RspecSequel
  module Matchers
    class HaveOneToOneMatcher < RspecSequel::Association
      def association_type
        :one_to_one
      end

      def valid?(db, i, c, attribute, options)
        matching = super

        matching
      end
    end

    def have_one_to_one(*args)
      HaveOneToOneMatcher.new(*args)
    end
  end
end
