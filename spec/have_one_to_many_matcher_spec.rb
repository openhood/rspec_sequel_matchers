require File.dirname(__FILE__) + "/spec_helper"

describe "have_one_to_many_matcher" do

  subject{ Item }

  describe "messages" do
    describe "without option" do
      it "should contain a description" do
        @matcher = have_one_to_many :comments
        @matcher.description.should == "have a one_to_many association :comments"
      end
      it "should set failure messages" do
        @matcher = have_one_to_many :comments
        @matcher.matches? subject
        @matcher.failure_message.should == "expected Item to have a one_to_many association :comments"
        @matcher.negative_failure_message.should == @matcher.failure_message.gsub("to have", "to not have")
      end
    end
    describe "with options" do
      it "should contain a description" do
        @matcher = have_one_to_many :comments, :class_name => "Comment"
        @matcher.description.should == 'have a one_to_many association :comments with :class_name => "Comment"'
      end
      it "should set failure messages" do
        @matcher = have_one_to_many :comments, :class_name => "Comment"
        @matcher.matches? subject
        @matcher.failure_message.should == 'expected Item to have a one_to_many association :comments with :class_name => "Comment"'
        @matcher.negative_failure_message.should == @matcher.failure_message.gsub("to have", "to not have")
      end
      it "should explicit used options if different than expected" do
        @matcher = have_one_to_many :comments, :class_name => "Price"
        @matcher.matches? subject
        @matcher.failure_message.should == 'expected Item to have a one_to_many association :comments with :class_name => "Price" expected :class_name == "Price" but found "Comment" instead'
        @matcher.negative_failure_message.should == @matcher.failure_message.gsub("to have", "to not have")
      end
    end
  end

  describe "matchers" do
    it{ should have_one_to_many(:comments) }
    it{ should have_one_to_many(:comments, :class_name => "Comment") }
    it{ should_not have_one_to_many(:prices) }
    it{ should_not have_one_to_many(:comments, :class_name => "Price") }
  end

end