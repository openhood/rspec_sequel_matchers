require File.dirname(__FILE__) + "/spec_helper"
require "yaml"

describe "have_column_matcher" do

  describe "messages" do

    it "should contain a description" do
      @matcher = have_column(:name)
      @matcher.description.should == "have a column :name"
      @matcher = have_column(:name, :type => :string)
      @matcher.description.should == "have a column :name with type string"
    end

    # it "should set column_exists? message" do
    #   @matcher = have_column(:password)
    #   @matcher.matches?(@model)
    #   @matcher.failure_message.should == "Expected Product to have column named password"
    # end
    # 
    # it "should set options_match? message" do
    #   @matcher = have_column(:name, :type => :integer)
    #   @matcher.matches?(@model)
    #   @matcher.failure_message.should == "Expected Product to have column name with options {:type=>"integer"}, got {:type=>"string"}"
    # end
  end

  describe "matchers" do
    subject{ Sequel::Model(:items) }
    it{ should have_column(:name) }
    it{ should have_column :name, :type => :string }
    it{ should have_column :name, :type => String }
    it{ should_not have_column :wrong_name }
    it{ should_not have_column :name, :type => :integer }
  end

end