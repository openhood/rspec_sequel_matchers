require File.dirname(__FILE__) + "/spec_helper"

describe "validate_includes_matcher" do

  before do
    define_model :item do
      plugin :validation_helpers
      def validate
        validates_includes ["Joseph", "Jonathan"], :name, :allow_nil => true
      end
    end
  end

  subject{ Item }

  describe "arguments" do
    it "should require attribute" do
      expect do
        @matcher = validate_includes
      end.to raise_error(ArgumentError)
    end
    it "should require additionnal parameters" do
      expect do
        @matcher = validate_includes :name
      end.to raise_error(ArgumentError)
    end
    it "should refuse invalid additionnal parameters" do
      expect do
        @matcher = validate_includes :id, :name
      end.to raise_error(ArgumentError)
    end
    it "should accept valid additionnal parameters" do
      expect do
        @matcher = validate_includes ["Joseph", "Jonathan"], :name
      end.not_to raise_error
    end
  end

  describe "messages" do
    describe "without option" do
      it "should contain a description" do
        @matcher = validate_includes ["Joseph", "Jonathan"], :name
        expect( @matcher.description ).to eq 'validate that :name is included in ["Joseph", "Jonathan"]'
      end
      it "should set failure messages" do
        @matcher = validate_includes ["Joseph", "Jonathan"], :name
        @matcher.matches? subject
        expect( @matcher.failure_message ).to eq "expected Item to " + @matcher.description
        expect( @matcher.failure_message_when_negated ).to eq "expected Item to not " + @matcher.description
      end
    end
    describe "with options" do
      it "should contain a description" do
        @matcher = validate_includes ["Joseph", "Jonathan"], :name, :allow_nil => true
        expect( @matcher.description ).to eq 'validate that :name is included in ["Joseph", "Jonathan"] with option(s) :allow_nil => true'
      end
      it "should set failure messages" do
        @matcher = validate_includes ["Joseph", "Jonathan"], :price, :allow_nil => true
        @matcher.matches? subject
        expect( @matcher.failure_message ).to eq "expected Item to " + @matcher.description
        expect( @matcher.failure_message_when_negated ).to eq "expected Item to not " + @matcher.description
      end
      it "should explicit used options if different than expected" do
        @matcher = validate_includes ["Joseph", "Jonathan"], :name, :allow_blank => true
        @matcher.matches? subject
        explanation = " but called with option(s) :allow_nil => true instead"
        expect( @matcher.failure_message ).to eq "expected Item to " + @matcher.description + explanation
        expect( @matcher.failure_message_when_negated ).to eq "expected Item to not " + @matcher.description + explanation
      end
      it "should warn if invalid options are used" do
        @matcher = validate_includes ["Joseph", "Jonathan"], :name, :allow_anything => true
        @matcher.matches? subject
        explanation = " but option :allow_anything is not valid"
        expect( @matcher.failure_message ).to eq "expected Item to " + @matcher.description + explanation
        expect( @matcher.failure_message_when_negated ).to eq "expected Item to not " + @matcher.description + explanation
      end
    end
  end

  describe "matchers" do
    it{ is_expected.to validate_includes(["Joseph", "Jonathan"], :name) }
    it{ is_expected.to validate_includes(["Joseph", "Jonathan"], :name, :allow_nil => true) }
    it{ is_expected.not_to validate_includes(["Joseph", "Jonathan"], :price) }
    it{ is_expected.not_to validate_includes(["Joseph", "Jonathan", "Alice"], :name) }
    it{ is_expected.not_to validate_includes(["Joseph", "Jonathan"], :name, :allow_blank => true) }
  end

end
