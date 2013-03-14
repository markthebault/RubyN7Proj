require_relative 'spec_helper'
require 'discussion'

describe Discussion do
  subject { Discussion.create(
            :title => "Discussion",
            :user_id => "1"
            ) }

  it { should be_valid }
  
  context "Argument missing" do
    it "should not be valid without title" do
      subject.title = nil
      subject.should_not be_valid
    end
  end
end
