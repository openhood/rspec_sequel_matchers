require File.dirname(__FILE__) + "/spec_helper"

describe "validate_length_range_matcher" do

  before :all do
    define_model :item do
      plugin :validation_helpers
      def validate
        validates_length_range 1..10, :name, :allow_nil => true
      end
    end
  end

  subject{ Item }

  describe "arguments" do
    it "should require attribute" do
      lambda{
        @matcher = validate_length_range
      }.should raise_error(ArgumentError)
    end
    it "should require additionnal parameters" do
      lambda{
        @matcher = validate_length_range :name
      }.should raise_error(ArgumentError)
    end
    it "should refuse invalid additionnal parameters" do
      lambda{
        @matcher = validate_length_range :id, :name
      }.should raise_error(ArgumentError)
    end
    it "should accept valid additionnal parameters" do
      lambda{
        @matcher = validate_length_range 1..10, :name
      }.should_not raise_error(ArgumentError)
    end
  end

  describe "messages" do
    describe "without option" do
      it "should contain a description" do
        @matcher = validate_length_range 1..10, :name
        @matcher.description.should == "validate that :name length is included in 1..10"
      end
      it "should set failure messages" do
        @matcher = validate_length_range 1..10, :name
        @matcher.matches? subject
        @matcher.failure_message.should == "expected Item to " + @matcher.description
        @matcher.negative_failure_message.should == "expected Item to not " + @matcher.description
      end
    end
    describe "with options" do
      it "should contain a description" do
        @matcher = validate_length_range 1..10, :name, :allow_nil => true
        @matcher.description.should == "validate that :name length is included in 1..10 with option(s) :allow_nil => true"
      end
      it "should set failure messages" do
        @matcher = validate_length_range 1..10, :price, :allow_nil => true
        @matcher.matches? subject
        @matcher.failure_message.should == "expected Item to " + @matcher.description
        @matcher.negative_failure_message.should == "expected Item to not " + @matcher.description
      end
      it "should explicit used options if different than expected" do
        @matcher = validate_length_range 1..10, :name, :allow_blank => true
        @matcher.matches? subject
        explanation = " but called with option(s) :allow_nil => true instead"
        @matcher.failure_message.should == "expected Item to " + @matcher.description + explanation
        @matcher.negative_failure_message.should == "expected Item to not " + @matcher.description + explanation
      end
      it "should warn if invalid options are used" do
        @matcher = validate_length_range 1..10, :name, :allow_anything => true
        @matcher.matches? subject
        explanation = " but option :allow_anything is not valid"
        @matcher.failure_message.should == "expected Item to " + @matcher.description + explanation
        @matcher.negative_failure_message.should == "expected Item to not " + @matcher.description + explanation
      end
    end
  end

  describe "matchers" do
    it{ should validate_length_range(1..10, :name) }
    it{ should validate_length_range(1..10, :name, :allow_nil => true) }
    it{ should_not validate_length_range(1..10, :price) }
    it{ should_not validate_length_range(0..10, :name) }
    it{ should_not validate_length_range(1..10, :name, :allow_blank => true) }
  end

end