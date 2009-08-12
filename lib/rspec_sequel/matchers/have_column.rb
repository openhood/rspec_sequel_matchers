module RspecSequel
  module Matchers

    class HaveColumnMatcher < RspecSequel::Base
      def description
        desc = "have a column #{@attribute.inspect}"
        desc << " with type #{@options[:type]}" if @options[:type]
        desc
      end

      def valid?(db, i, c, attribute, options)

        # check column existance
        col = db.schema(c.table_name).detect{|col| col[0]==attribute}
        matching = !col.nil?

        # check type
        if @options[:type]
          expected = db.send(:type_literal, {:type => options[:type]}).to_s
          if matching
            found = [col[1][:type].to_s, col[1][:db_type].to_s]
            @suffix << "(type found: #{found.uniq.join(", ")})"
            matching &&= found.include?(expected)
          end
        end
        matching
      end
    end

    def have_column(*args)
      HaveColumnMatcher.new(*args)
    end

  end
end