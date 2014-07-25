require File.dirname(__FILE__) + "/spec_helper"

describe "validate_unique_matcher" do

  before do
    define_model :item do
      plugin :validation_helpers
      def validate
        validates_unique [:id, :name], :name, :message => "Hello"
      end
    end
  end

  subject{ Item }

  describe "arguments" do
    it "should require attribute" do
      expect do
        @matcher = validate_unique
      end.to raise_error
    end
    it "should refuse additionnal parameters" do
      expect do
        @matcher = validate_unique :name, :id
      end.to raise_error
    end
  end

  describe "messages" do
    describe "without option" do
      it "should contain a description" do
        @matcher = validate_unique :name
        expect( @matcher.description ).to eq "validate uniqueness of :name"
      end
      it "should set failure messages" do
        @matcher = validate_unique :name
        @matcher.matches? subject
        expect( @matcher.failure_message ).to eq "expected Item to " + @matcher.description
        expect( @matcher.failure_message_when_negated ).to eq "expected Item to not " + @matcher.description
      end
    end
    describe "with options" do
      it "should contain a description" do
        @matcher = validate_unique :name, :message => "Hello"
        expect( @matcher.description ).to eq 'validate uniqueness of :name with option(s) :message => "Hello"'
      end
      it "should set failure messages" do
        @matcher = validate_unique :price, :message => "Hello"
        @matcher.matches? subject
        expect( @matcher.failure_message ).to eq "expected Item to " + @matcher.description
        expect( @matcher.failure_message_when_negated ).to eq "expected Item to not " + @matcher.description
      end
      it "should explicit used options if different than expected" do
        @matcher = validate_unique :name, :message => "Hello world"
        @matcher.matches? subject
        explanation = ' but called with option(s) :message => "Hello" instead'
        expect( @matcher.failure_message ).to eq "expected Item to " + @matcher.description + explanation
        expect( @matcher.failure_message_when_negated ).to eq "expected Item to not " + @matcher.description + explanation
      end
      it "should warn if invalid options are used" do
        @matcher = validate_unique :name, :allow_nil => true
        @matcher.matches? subject
        explanation = " but option :allow_nil is not valid"
        expect( @matcher.failure_message ).to eq "expected Item to " + @matcher.description + explanation
        expect( @matcher.failure_message_when_negated ).to eq "expected Item to not " + @matcher.description + explanation
      end
    end
  end

  describe "matchers" do
    it{ is_expected.to validate_unique(:name) }
    it{ is_expected.to validate_unique([:id, :name]) }
    it{ is_expected.to validate_unique(:name, :message => "Hello") }
    it{ is_expected.not_to validate_unique(:id) }
    it{ is_expected.not_to validate_unique(:price) }
    it{ is_expected.not_to validate_unique(:name, :allow_nil => true) }
  end

end
