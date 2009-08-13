require File.dirname(__FILE__) + "/spec_helper"

describe "have_many_to_one_matcher" do

  before :all do
    define_model :item
    define_model :comment do
      many_to_one :item
    end
  end

  subject{ Comment }

  describe "messages" do
    describe "without option" do
      it "should contain a description" do
        @matcher = have_many_to_one :item
        @matcher.description.should == "have a many_to_one association :item"
      end
      it "should set failure messages" do
        @matcher = have_many_to_one :item
        @matcher.matches? subject
        @matcher.failure_message.should == "expected Comment to " + @matcher.description
        @matcher.negative_failure_message.should == "expected Comment to not " + @matcher.description
      end
    end
    describe "with options" do
      it "should contain a description" do
        @matcher = have_many_to_one :item, :class_name => "Item"
        @matcher.description.should == 'have a many_to_one association :item with :class_name => "Item"'
      end
      it "should set failure messages" do
        @matcher = have_many_to_one :item, :class_name => "Item"
        @matcher.matches? subject
        @matcher.failure_message.should == "expected Comment to " + @matcher.description
        @matcher.negative_failure_message.should == "expected Comment to not " + @matcher.description
      end
      it "should explicit used options if different than expected" do
        @matcher = have_many_to_one :item, :class_name => "Price"
        @matcher.matches? subject
        explanation = ' expected :class_name == "Price" but found "Item" instead'
        @matcher.failure_message.should == "expected Comment to " + @matcher.description + explanation
        @matcher.negative_failure_message.should == "expected Comment to not " + @matcher.description + explanation
      end
    end
  end

  describe "matchers" do
    it{ should have_many_to_one(:item) }
    it{ should have_many_to_one(:item, :class_name => "Item") }
    it{ should_not have_many_to_one(:price) }
    it{ should_not have_many_to_one(:item, :class_name => "Price") }
  end

end