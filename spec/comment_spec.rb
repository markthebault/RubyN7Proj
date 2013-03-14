require_relative 'spec_helper'
require 'comment'

describe Comment do
  subject { Comment.create(:user_id => "1", :discussion_id => "1", :comment => "bijour commenq'ca va bien ???") }

  it { should be_valid }
  
  context "Argument missing" do
    it "should not be valid without comment" do
      subject.comment = nil
      subject.should_not be_valid
    end



  end
end
