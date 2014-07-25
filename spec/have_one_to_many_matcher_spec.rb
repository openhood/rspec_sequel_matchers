require File.dirname(__FILE__) + "/spec_helper"

describe "have_one_to_many_matcher" do

  before do
    define_model :item do
      one_to_many :comments
    end
    define_model :comment
  end

  subject{ Item }

  describe "messages" do
    describe "without option" do
      it "should contain a description" do
        @matcher = have_one_to_many :comments
        expect( @matcher.description ).to eq "have a one_to_many association :comments"
      end
      it "should set failure messages" do
        @matcher = have_one_to_many :comments
        @matcher.matches? subject
        expect( @matcher.failure_message ).to eq "expected Item to " + @matcher.description
        expect( @matcher.failure_message_when_negated ).to eq "expected Item to not " + @matcher.description
      end
    end
    describe "with options" do
      it "should contain a description" do
        @matcher = have_one_to_many :comments, :class_name => "Comment"
        expect( @matcher.description ).to eq 'have a one_to_many association :comments with option(s) :class_name => "Comment"'
      end
      it "should set failure messages" do
        @matcher = have_one_to_many :comments, :class_name => "Comment"
        @matcher.matches? subject
        expect( @matcher.failure_message ).to eq "expected Item to " + @matcher.description
        expect( @matcher.failure_message_when_negated ).to eq "expected Item to not " + @matcher.description
      end
      it "should explicit used options if different than expected" do
        @matcher = have_one_to_many :comments, :class_name => "Price"
        @matcher.matches? subject
        explanation = ' expected :class_name == "Price" but found "Comment" instead'
        expect( @matcher.failure_message ).to eq "expected Item to " + @matcher.description + explanation
        expect( @matcher.failure_message_when_negated ).to eq "expected Item to not " + @matcher.description + explanation
      end
    end
  end

  describe "matchers" do
    it{ is_expected.to have_one_to_many(:comments) }
    it{ is_expected.to have_one_to_many(:comments, :class_name => "Comment") }
    it{ is_expected.not_to have_one_to_many(:prices) }
    it{ is_expected.not_to have_one_to_many(:comments, :class_name => "Price") }
  end

end