require File.dirname(__FILE__) + "/spec_helper"

describe "have_column_matcher" do

  before :all do
    define_model :Item
  end

  subject{ Item }

  describe "messages" do
    describe "without type" do
      it "should contain a description" do
        @matcher = have_column :name
        @matcher.description.should == "have a column :name"
      end
      it "should set failure messages" do
        @matcher = have_column :name
        @matcher.matches? subject
        @matcher.failure_message.should == "expected Item to have a column :name"
        @matcher.negative_failure_message.should == @matcher.failure_message.gsub("to have", "to not have")
      end
    end
    describe "with type as symbol" do
      it "should contain a description" do
        @matcher = have_column :name, :type => :string
        @matcher.description.should == "have a column :name with type string"
      end
      it "should set failure messages" do
        @matcher = have_column :password, :type => :string
        @matcher.matches? subject
        @matcher.failure_message.should == "expected Item to have a column :password with type string"
        @matcher.negative_failure_message.should == @matcher.failure_message.gsub("to have", "to not have")
      end
    end
    describe "with type as object" do
      it "should contain a description" do
        @matcher = have_column :name, :type => String
        @matcher.description.should == "have a column :name with type String"
      end
      it "should set failure messages" do
        @matcher = have_column :password, :type => String
        @matcher.matches? subject
        @matcher.failure_message.should == "expected Item to have a column :password with type String"
        @matcher.negative_failure_message.should == @matcher.failure_message.gsub("to have", "to not have")
      end
      it "should explicit found type if different than expected" do
        @matcher = have_column :name, :type => Integer
        @matcher.matches? subject
        @matcher.failure_message.should == "expected Item to have a column :name with type Integer (type found: string, varchar(255))"
        @matcher.negative_failure_message.should == @matcher.failure_message.gsub("to have", "to not have")
      end
    end
    describe "on anonymous Sequel::Model class" do
      it "should set failure messages" do
        @matcher = have_column :password
        @matcher.matches? Sequel::Model(:comments)
        @matcher.failure_message.should == "expected comments to have a column :password"
        @matcher.negative_failure_message.should == @matcher.failure_message.gsub("to have", "to not have")
      end
    end
    describe "on Sequel::Model class" do
      it "should set failure messages" do
        @matcher = have_column :password
        @matcher.matches? Item
        @matcher.failure_message.should == "expected Item to have a column :password"
        @matcher.negative_failure_message.should == @matcher.failure_message.gsub("to have", "to not have")
      end
    end
    describe "on Sequel::Model instance" do
      it "should set failure messages" do
        @matcher = have_column :password
        @matcher.matches? Item.new
        @matcher.failure_message.should == "expected #<Item @values={}> to have a column :password"
        @matcher.negative_failure_message.should == @matcher.failure_message.gsub("to have", "to not have")
      end
    end
  end

  describe "matchers" do
    it{ should have_column(:name) }
    it{ should have_column(:name, :type => :string) }
    it{ should have_column(:name, :type => String) }
    it{ should_not have_column(:password) }
    it{ should_not have_column(:name, :type => :integer) }
  end

end