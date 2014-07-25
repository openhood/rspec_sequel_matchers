require File.dirname(__FILE__) + "/spec_helper"

describe "have_column_matcher" do

  before do
    define_model :item
  end

  subject{ Item }

  describe "messages" do
    describe "without type" do
      it "should contain a description" do
        @matcher = have_column :name
        expect( @matcher.description ).to eq "have a column :name"
      end
      it "should set failure messages" do
        @matcher = have_column :name
        @matcher.matches? subject
        expect( @matcher.failure_message ).to eq "expected Item to " + @matcher.description
        expect( @matcher.failure_message_when_negated ).to eq "expected Item to not " + @matcher.description
      end
    end
    describe "with type as symbol" do
      it "should contain a description" do
        @matcher = have_column :name, :type => :string
        expect( @matcher.description ).to eq "have a column :name with type string"
      end
      it "should set failure messages" do
        @matcher = have_column :password, :type => :string
        @matcher.matches? subject
        expect( @matcher.failure_message ).to eq "expected Item to " + @matcher.description
        expect( @matcher.failure_message_when_negated ).to eq "expected Item to not " + @matcher.description
      end
    end
    describe "with type as object" do
      it "should contain a description" do
        @matcher = have_column :name, :type => String
        expect( @matcher.description ).to eq "have a column :name with type String"
      end
      it "should set failure messages" do
        @matcher = have_column :password, :type => String
        @matcher.matches? subject
        expect( @matcher.failure_message ).to eq "expected Item to " + @matcher.description
        expect( @matcher.failure_message_when_negated ).to eq "expected Item to not " + @matcher.description
      end
      it "should explicit found type if different than expected" do
        @matcher = have_column :name, :type => Integer
        @matcher.matches? subject
        explanation = " (type found: string, varchar(255))"
        expect( @matcher.failure_message ).to eq "expected Item to " + @matcher.description + explanation
        expect( @matcher.failure_message_when_negated ).to eq "expected Item to not " + @matcher.description + explanation
      end
    end
    describe "on anonymous Sequel::Model class" do
      it "should set failure messages" do
        @matcher = have_column :password
        @matcher.matches? Sequel::Model(:comments)
        expect( @matcher.failure_message ).to eq "expected Comment to " + @matcher.description
        expect( @matcher.failure_message_when_negated ).to eq "expected Comment to not " + @matcher.description
      end
    end
    describe "on Sequel::Model class" do
      it "should set failure messages" do
        @matcher = have_column :password
        @matcher.matches? Item
        expect( @matcher.failure_message ).to eq "expected Item to " + @matcher.description
        expect( @matcher.failure_message_when_negated ).to eq "expected Item to not " + @matcher.description
      end
    end
    describe "on Sequel::Model instance" do
      it "should set failure messages" do
        @matcher = have_column :password
        @matcher.matches? Item.new
        expect( @matcher.failure_message ).to eq "expected #<Item @values={}> to " + @matcher.description
        expect( @matcher.failure_message_when_negated ).to eq "expected #<Item @values={}> to not " + @matcher.description
      end
    end
  end

  describe "matchers" do
    it{ is_expected.to have_column(:name) }
    it{ is_expected.to have_column(:name, :type => :string) }
    it{ is_expected.to have_column(:name, :type => String) }
    it{ is_expected.not_to have_column(:password) }
    it{ is_expected.not_to have_column(:name, :type => :integer) }
  end

end
