require File.dirname(__FILE__) + "/spec_helper"

class Item < Sequel::Model
  def validate
    validates_presence :id, :name, :allow_nil => true
  end
end

describe "validate_presence_matcher" do

  subject{ Item }

  describe "messages" do
    describe "without option" do
      it "should contain a description" do
        @matcher = validate_presence :name
        @matcher.description.should == "validate presence of :name"
      end
      it "should set failure messages" do
        @matcher = validate_presence :name
        @matcher.matches? subject
        @matcher.failure_message.should == "expected Item to validate presence of :name"
        @matcher.negative_failure_message.should == @matcher.failure_message.gsub("to validate", "to not validate")
      end
    end
    describe "with options" do
      it "should contain a description" do
        @matcher = validate_presence :name, :allow_nil => true
        @matcher.description.should == "validate presence of :name with :allow_nil => true"
      end
      it "should set failure messages" do
        @matcher = validate_presence :price, :allow_nil => true
        @matcher.matches? subject
        @matcher.failure_message.should == "expected Item to validate presence of :price with :allow_nil => true"
        @matcher.negative_failure_message.should == @matcher.failure_message.gsub("to validate", "to not validate")
      end
      it "should explicit used options if different than expected" do
        @matcher = validate_presence :name, :allow_blank => true
        @matcher.matches? subject
        @matcher.failure_message.should == "expected Item to validate presence of :name with :allow_blank => true but called with :allow_nil => true instead"
        @matcher.negative_failure_message.should == @matcher.failure_message.gsub("to validate", "to not validate")
      end
    end
  end

  describe "matchers" do
    it{ should validate_presence(:name) }
    it{ should validate_presence(:name, :allow_nil => true) }
    it{ should_not validate_presence(:price) }
    it{ should_not validate_presence(:name, :allow_blank => true) }
  end

end