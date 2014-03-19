require File.dirname(__FILE__) + "/spec_helper"

describe "validate_unique_matcher" do

  before do
    define_model :item do
      plugin :validation_helpers
      def validate
        validates_unique [:id, :name], :name, :message => "Hello"
      end
    end
  end

  subject{ Item }

  describe "arguments" do
    it "should require attribute" do
      lambda{
        @matcher = validate_unique
      }.should raise_error
    end
    it "should refuse additionnal parameters" do
      lambda{
        @matcher = validate_unique :name, :id
      }.should raise_error
    end
  end

  describe "messages" do
    describe "without option" do
      it "should contain a description" do
        @matcher = validate_unique :name
        @matcher.description.should == "validate uniqueness of :name"
      end
      it "should set failure messages" do
        @matcher = validate_unique :name
        @matcher.matches? subject
        @matcher.failure_message.should == "expected Item to " + @matcher.description
        @matcher.negative_failure_message.should == "expected Item to not " + @matcher.description
      end
    end
    describe "with options" do
      it "should contain a description" do
        @matcher = validate_unique :name, :message => "Hello"
        @matcher.description.should == 'validate uniqueness of :name with option(s) :message => "Hello"'
      end
      it "should set failure messages" do
        @matcher = validate_unique :price, :message => "Hello"
        @matcher.matches? subject
        @matcher.failure_message.should == "expected Item to " + @matcher.description
        @matcher.negative_failure_message.should == "expected Item to not " + @matcher.description
      end
      it "should explicit used options if different than expected" do
        @matcher = validate_unique :name, :message => "Hello world"
        @matcher.matches? subject
        explanation = ' but called with option(s) :message => "Hello" instead'
        @matcher.failure_message.should == "expected Item to " + @matcher.description + explanation
        @matcher.negative_failure_message.should == "expected Item to not " + @matcher.description + explanation
      end
      it "should warn if invalid options are used" do
        @matcher = validate_unique :name, :allow_nil => true
        @matcher.matches? subject
        explanation = " but option :allow_nil is not valid"
        @matcher.failure_message.should == "expected Item to " + @matcher.description + explanation
        @matcher.negative_failure_message.should == "expected Item to not " + @matcher.description + explanation
      end
    end
  end

  describe "matchers" do
    it{ should validate_unique(:name) }
    it{ should validate_unique([:id, :name]) }
    it{ should validate_unique(:name, :message => "Hello") }
    it{ should_not validate_unique(:id) }
    it{ should_not validate_unique(:price) }
    it{ should_not validate_unique(:name, :allow_nil => true) }
  end

end
