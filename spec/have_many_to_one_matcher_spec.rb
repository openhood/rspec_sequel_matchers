require File.dirname(__FILE__) + "/spec_helper"

describe "have_many_to_one_matcher" do

  before do
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
        expect( @matcher.description ).to eq "have a many_to_one association :item"
      end
      it "should set failure messages" do
        @matcher = have_many_to_one :item
        @matcher.matches? subject
        expect( @matcher.failure_message ).to eq "expected Comment to " + @matcher.description
        expect( @matcher.failure_message_when_negated ).to eq "expected Comment to not " + @matcher.description
      end
    end
    describe "with options" do
      it "should contain a description" do
        @matcher = have_many_to_one :item, :class_name => "Item"
        expect( @matcher.description ).to eq 'have a many_to_one association :item with option(s) :class_name => "Item"'
      end
      it "should set failure messages" do
        @matcher = have_many_to_one :item, :class_name => "Item"
        @matcher.matches? subject
        expect( @matcher.failure_message ).to eq "expected Comment to " + @matcher.description
        expect( @matcher.failure_message_when_negated ).to eq "expected Comment to not " + @matcher.description
      end
      it "should explicit used options if different than expected" do
        @matcher = have_many_to_one :item, :class_name => "Price"
        @matcher.matches? subject
        explanation = ' expected :class_name == "Price" but found "Item" instead'
        expect( @matcher.failure_message ).to eq "expected Comment to " + @matcher.description + explanation
        expect( @matcher.failure_message_when_negated ).to eq "expected Comment to not " + @matcher.description + explanation
      end
    end
  end

  describe "matchers" do
    it{ is_expected.to have_many_to_one(:item) }
    it{ is_expected.to have_many_to_one(:item, :class_name => "Item") }
    it{ is_expected.not_to have_many_to_one(:price) }
    it{ is_expected.not_to have_many_to_one(:item, :class_name => "Price") }
  end

end