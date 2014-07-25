require File.dirname(__FILE__) + "/spec_helper"

describe "have_many_to_many_matcher" do

  before do
    define_model :item
    define_model :comment do
      many_to_many :items
    end
  end

  subject{ Comment }

  describe "messages" do
    describe "without option" do
      it "should contain a description" do
        @matcher = have_many_to_many :items
        expect( @matcher.description ).to eq "have a many_to_many association :items"
      end
      it "should set failure messages" do
        @matcher = have_many_to_many :items
        @matcher.matches? subject
        expect( @matcher.failure_message ).to eq "expected Comment to " + @matcher.description
        expect( @matcher.failure_message_when_negated ).to eq "expected Comment to not " + @matcher.description
      end
    end
    describe "with options" do
      it "should contain a description" do
        @matcher = have_many_to_many :items, :class_name => "Item"
        expect( @matcher.description ).to eq 'have a many_to_many association :items with option(s) :class_name => "Item"'
      end
      it "should set failure messages" do
        @matcher = have_many_to_many :items, :class_name => "Item"
        @matcher.matches? subject
        expect( @matcher.failure_message ).to eq "expected Comment to " + @matcher.description
        expect( @matcher.failure_message_when_negated ).to eq "expected Comment to not " + @matcher.description
      end
      it "should explicit used options if different than expected" do
        @matcher = have_many_to_many :items, :class_name => "Price"
        @matcher.matches? subject
        explanation = ' expected :class_name == "Price" but found "Item" instead'
        expect( @matcher.failure_message ).to eq "expected Comment to " + @matcher.description + explanation
        expect( @matcher.failure_message_when_negated ).to eq "expected Comment to not " + @matcher.description + explanation
      end
    end
  end

  describe "matchers" do
    it{ is_expected.to have_many_to_many(:items) }
    it{ is_expected.to have_many_to_many(:items, :class_name => "Item", :join_table => :comments_items) }
    it{ is_expected.not_to have_many_to_many(:prices) }
    it{ is_expected.not_to have_many_to_many(:items, :class_name => "Price") }
    it{ is_expected.not_to have_many_to_many(:items, :join_table => :items_comments) }
  end

end
