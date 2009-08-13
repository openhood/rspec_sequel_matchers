require File.dirname(__FILE__) + "/spec_helper"

describe "validate_numeric_matcher" do

  before :all do
    define_model :item do
      plugin :validation_helpers
      def validate
        validates_numeric [:id, :name], :allow_nil => true
      end
    end
  end

  subject{ Item }

  describe "arguments" do
    it "should require attribute" do
      lambda{
        @matcher = validate_numeric
      }.should raise_error(ArgumentError)
    end
    it "should refuse additionnal parameters" do
      lambda{
        @matcher = validate_numeric :name, :id
      }.should raise_error(ArgumentError)
    end
  end

  describe "messages" do
    describe "without option" do
      it "should contain a description" do
        @matcher = validate_numeric :name
        @matcher.description.should == "validate that :name is a valid float"
      end
      it "should set failure messages" do
        @matcher = validate_numeric :name
        @matcher.matches? subject
        @matcher.failure_message.should == "expected Item to " + @matcher.description
        @matcher.negative_failure_message.should == "expected Item to not " + @matcher.description
      end
    end
    describe "with options" do
      it "should contain a description" do
        @matcher = validate_numeric :name, :allow_nil => true
        @matcher.description.should == "validate that :name is a valid float with option(s) :allow_nil => true"
      end
      it "should set failure messages" do
        @matcher = validate_numeric :price, :allow_nil => true
        @matcher.matches? subject
        @matcher.failure_message.should == "expected Item to " + @matcher.description
        @matcher.negative_failure_message.should == "expected Item to not " + @matcher.description
      end
      it "should explicit used options if different than expected" do
        @matcher = validate_numeric :name, :allow_blank => true
        @matcher.matches? subject
        explanation = " but called with option(s) :allow_nil => true instead"
        @matcher.failure_message.should == "expected Item to " + @matcher.description + explanation
        @matcher.negative_failure_message.should == "expected Item to not " + @matcher.description + explanation
      end
      it "should warn if invalid options are used" do
        @matcher = validate_numeric :name, :allow_anything => true
        @matcher.matches? subject
        explanation = " but option :allow_anything is not valid"
        @matcher.failure_message.should == "expected Item to " + @matcher.description + explanation
        @matcher.negative_failure_message.should == "expected Item to not " + @matcher.description + explanation
      end
    end
  end

  describe "matchers" do
    it{ should validate_numeric(:name) }
    it{ should validate_numeric(:name, :allow_nil => true) }
    it{ should_not validate_numeric(:price) }
    it{ should_not validate_numeric(:name, :allow_blank => true) }
  end

end