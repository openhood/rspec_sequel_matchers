require File.dirname(__FILE__) + "/spec_helper"
require "yaml"

class Item < Sequel::Model
end

describe "have_column_matcher" do

  before do
    @model = Sequel::Model(:items)
  end

  describe "messages" do
    describe "without type" do
      it "should contain a description" do
        @matcher = have_column(:name)
        @matcher.description.should == "have a column :name"
      end
      it "should set failure messages" do
        @matcher = have_column(:name)
        @matcher.matches?(@model)
        @matcher.failure_message.should == "expected items to have a column :name"
        @matcher.negative_failure_message.should == "expected items to not have a column :name"
      end
    end
    describe "with type as symbol" do
      it "should contain a description" do
        @matcher = have_column(:name, :type => :string)
        @matcher.description.should == "have a column :name with type string"
      end
      it "should set failure messages" do
        @matcher = have_column(:password, :type => :string)
        @matcher.matches?(@model)
        @matcher.failure_message.should == "expected items to have a column :password with type string"
        @matcher.negative_failure_message.should == "expected items to not have a column :password with type string"
      end
    end
    describe "with type as object" do
      it "should contain a description" do
        @matcher = have_column(:name, :type => String)
        @matcher.description.should == "have a column :name with type String"
      end
      it "should set failure messages" do
        @matcher = have_column(:password, :type => String)
        @matcher.matches?(@model)
        @matcher.failure_message.should == "expected items to have a column :password with type String"
        @matcher.negative_failure_message.should == "expected items to not have a column :password with type String"
      end
      it "should explicit found type if different than expected" do
        @matcher = have_column(:name, :type => Integer)
        @matcher.matches?(@model)
        @matcher.failure_message.should == "expected items to have a column :name with type Integer (type found: string, varchar(255))"
        @matcher.negative_failure_message.should == "expected items to not have a column :name with type Integer (type found: string, varchar(255))"
      end
    end
    describe "on Sequel::Model class" do
      it "should set failure messages" do
        @matcher = have_column(:password)
        @matcher.matches?(Item)
        @matcher.failure_message.should == "expected Item to have a column :password"
        @matcher.negative_failure_message.should == "expected Item to not have a column :password"
      end
    end
    describe "on Sequel::Model instance" do
      it "should set failure messages" do
        @matcher = have_column(:password)
        @matcher.matches?(Item.new)
        @matcher.failure_message.should == "expected #<Item @values={}> to have a column :password"
        @matcher.negative_failure_message.should == "expected #<Item @values={}> to not have a column :password"
      end
    end
  end

  describe "matchers" do
    subject{ @model }
    it{ should have_column(:name) }
    it{ should have_column :name, :type => :string }
    it{ should have_column :name, :type => String }
    it{ should_not have_column :wrong_name }
    it{ should_not have_column :name, :type => :integer }
  end

end