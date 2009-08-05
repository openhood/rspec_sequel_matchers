module RspecSequel
  module Matchers

    class Base
      def initialize(attribute, options={})
        @attribute = attribute.to_sym
        @options = options
        @description = []
      end
      def matches?(target)
        @suffix = []
        if target.is_a?(Sequel::Model)
          @prefix = "expected #{target.inspect} to"
          valid?(target.db, target, target.class, @attribute, @options)
        else
          @prefix = "expected #{target.name} to"
          valid?(target.db, target.new, target, @attribute, @options)
        end
      end
      def failure_message
        @prefix + description + @suffix.join(" ")
      end
      def negative_failure_message
        @prefix + " not" + description + @suffix.join(" ")
      end
    end

    class HaveColumnMatcher < Base
      def description
        desc = []
        desc << "have a column :#{@attribute}"
        desc << "with type #{@options[:type]}" if @options[:type]
        desc.join " "
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