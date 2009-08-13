require File.dirname(__FILE__) + "/spec_helper"

describe "have_many_to_many_matcher" do

  before :all do
    define_model(:Item)
    define_model(:Comment){
      many_to_many :items
    }
  end

  subject{ Comment }

  describe "messages" do
    describe "without option" do
      it "should contain a description" do
        @matcher = have_many_to_many :items
        @matcher.description.should == "have a many_to_many association :items"
      end
      it "should set failure messages" do
        @matcher = have_many_to_many :items
        @matcher.matches? subject
        @matcher.failure_message.should == "expected Comment to have a many_to_many association :items"
        @matcher.negative_failure_message.should == @matcher.failure_message.gsub("to have", "to not have")
      end
    end
    describe "with options" do
      it "should contain a description" do
        @matcher = have_many_to_many :items, :class_name => "Item"
        @matcher.description.should == 'have a many_to_many association :items with :class_name => "Item"'
      end
      it "should set failure messages" do
        @matcher = have_many_to_many :items, :class_name => "Item"
        @matcher.matches? subject
        @matcher.failure_message.should == 'expected Comment to have a many_to_many association :items with :class_name => "Item"'
        @matcher.negative_failure_message.should == @matcher.failure_message.gsub("to have", "to not have")
      end
      it "should explicit used options if different than expected" do
        @matcher = have_many_to_many :items, :class_name => "Price"
        @matcher.matches? subject
        @matcher.failure_message.should == 'expected Comment to have a many_to_many association :items with :class_name => "Price" expected :class_name == "Price" but found "Item" instead'
        @matcher.negative_failure_message.should == @matcher.failure_message.gsub("to have", "to not have")
      end
    end
  end

  describe "matchers" do
    it{ should have_many_to_many(:items) }
    it{ should have_many_to_many(:items, :class_name => "Item", :join_table => :comments_items) }
    it{ should_not have_many_to_many(:prices) }
    it{ should_not have_many_to_many(:items, :class_name => "Price") }
    it{ should_not have_many_to_many(:items, :join_table => :items_comments) }
  end

end