require File.dirname(__FILE__) + "/spec_helper"

describe "have_one_to_one_matcher" do

  before do
    define_model :item do
      one_to_one :profile
    end
    define_model :profile
  end

  subject { Item }

  describe "messages" do
    describe "without option" do
      it "should contain a description" do
        @matcher = have_one_to_one :profile
        expect( @matcher.description ).to eq "have a one_to_one association :profile"
      end
      it "should set failure messages" do
        @matcher = have_one_to_one :profile
        @matcher.matches? subject
        expect( @matcher.failure_message ).to eq "expected Item to " + @matcher.description
        expect( @matcher.failure_message_when_negated ).to eq "expected Item to not " + @matcher.description
      end
    end
    describe "with options" do
      it "should contain a description" do
        @matcher = have_one_to_one :profile, :class_name => "Profile"
        expect( @matcher.description ).to eq 'have a one_to_one association :profile with option(s) :class_name => "Profile"'
      end
      it "should set failure messages" do
        @matcher = have_one_to_one :profile, :class_name => "Profile"
        @matcher.matches? subject
        expect( @matcher.failure_message ).to eq "expected Item to " + @matcher.description
        expect( @matcher.failure_message_when_negated ).to eq "expected Item to not " + @matcher.description
      end
      it "should explicit used options if different than expected" do
        @matcher = have_one_to_one :profile, :class_name => "Price"
        @matcher.matches? subject
        explanation = ' expected :class_name == "Price" but found "Profile" instead'
        expect( @matcher.failure_message ).to eq "expected Item to " + @matcher.description + explanation
        expect( @matcher.failure_message_when_negated ).to eq "expected Item to not " + @matcher.description + explanation
      end
    end
  end

end
