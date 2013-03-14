require_relative 'spec_helper'
require 'user'

describe User do
  subject { User.create(:name => "Marco", :password => "1234", :email => "marco@free.fr") }

  it { should be_valid }
  
  context "Argument missing" do
    it "should not be valid without name" do
      subject.name = nil
      subject.should_not be_valid
    end

    it "should not be valid without password" do
      subject.password = nil
      subject.should_not be_valid
    end
    
    it "should not be valid without email" do
      subject.email = nil
      subject.should_not be_valid
    end



  end
end
