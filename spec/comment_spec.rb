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

decribe "using routes" do
  
  it 'get /discussions => show a list of discussions' do
  
  end
  
  it 'get /discussion/new => show a form to create an discussion' do
  
  end
  
  it 'post /discussion => create new discussion' do
  
  end
  
  it 'get /discussion/:id => show a discussion that correspond an ID' do
  
  end
  
  
  it 'patch /discussion/id => modify discussion' do
  
  end
  
  it 'delete /discussion/:id => delete the discussion that corresponds a the id' do
  
  end

end
