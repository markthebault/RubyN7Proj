require_relative 'spec_helper'
require 'comment'

describe Comment do
  subject { Comment.create(:discussion_id => 1, :comment => "bijour commenq'ca va bien ???") }

  it { should be_valid }
  
  context "Argument missing" do
    it "should not be valid without comment" do
      subject.comment = nil
      subject.should_not be_valid
    end
  end
end


describe "Route: " do
  it "get '/discussion/:id/comment/new' => page to create new comment" do
    
    d = Discussion.new
    d.title = "un titre"
    d.content = "un contenu"
    d.user_id = 1
    d.save
    
    get "/discussion/#{d.id}/comment/new"
    last_response.body.should match /<form/
  
  end
  
  
  it " post '/dicussion/:id/comment'  =>  post comment to a discussion" do
    d = Discussion.new
    d.title = "un titre"
    d.content = "un contenu"
    d.user_id = 1
    d.save
    
   coms = Comment.where(:discussion_id => d.id).all 
   for c in coms
    c.destroy 
   end
   
   post "/dicussion/#{d.id}/comment", {:comment => "un commentaire"}
   Comment.where(:discussion_id => d.id).should_not be_nil
  end
  
  it "delete '/discussion/:idDiscuss/comment/:idCom' => delete comment from a discussion" do
    d = Discussion.new
    d.title = "un titre"
    d.content = "un contenu"
    d.user_id = 1
    d.save
    
    c = Comment.new
    c.comment = "unComment"
    c.discussion_id = d.id
    c.save
    
   
   delete "/discussion/#{d.id}/comment/#{c.id}"
   Comment.find_by_id(c.id).should be_nil
  end
  

end

