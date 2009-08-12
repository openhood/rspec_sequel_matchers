require File.dirname(__FILE__) + "/spec_helper"

class Item < Sequel::Model
end
class Comment < Sequel::Model
  many_to_one :item
end

describe "have_many_to_one_matcher" do

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
        @matcher.failure_message.should == "expected Comment to have a many_to_one association :item"
        @matcher.negative_failure_message.should == @matcher.failure_message.gsub("to have", "to not have")
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
        @matcher.failure_message.should == 'expected Comment to have a many_to_one association :item with :class_name => "Item"'
        @matcher.negative_failure_message.should == @matcher.failure_message.gsub("to have", "to not have")
      end
      it "should explicit used options if different than expected" do
        @matcher = have_many_to_one :item, :class_name => "Price"
        @matcher.matches? subject
        @matcher.failure_message.should == 'expected Comment to have a many_to_one association :item with :class_name => "Price" expected :class_name == "Price" but found "Item" instead'
        @matcher.negative_failure_message.should == @matcher.failure_message.gsub("to have", "to not have")
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