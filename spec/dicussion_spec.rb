require_relative 'spec_helper'
require 'discussion'

describe Discussion do
  subject { Discussion.create(
            :title => "Discussion",
            :content => "un texte",
            :user_id => 1
            ) }

  it { should be_valid }
  
  context "Argument missing" do
    it "should not be valid without title" do
      subject.title = nil
      subject.should_not be_valid
    end
  end
end


describe "using routes" do
  
  it 'get /discussions => show a list of discussions' do
    get '/discussions'
    last_response.body.should match /dicussions/
    last_response.body.should match /href="\/discussion\/new"/
  end
  
  it 'get /discussion/new => show a form to create an discussion' do
    get '/discussion/new'
    last_response.body.should match /<form/
    last_response.body.should match /action="\/discussion"/
  end
  
  it 'post /discussion => create new discussion' do
    d = Discussion.find_by_title("oldtitle")
    if d then d.destroy end  
  
      post '/discussion', { :title => "super title", :content => "an content", :user => "toto" }
      last_response.should be_redirect
      Discussion.find_by_title("super title").should_not be_nil 
      
      last_response.should be_redirect
  end
  
  it 'get /discussion/:id => show a discussion that correspond an ID' do
  get '/discussion/new'
    last_response.body.should match /<form/
  end
  
  
  it 'put /discussion/id => modify discussion' do
    d = Discussion.find_by_title("oldtitle")
    if d then d.destroy end
    
    d = Discussion.new
    d.title = "oldtitle"
    d.content ="tutu"
    d.save

    put "/discussion/#{d.id}", {:title => "newtitle", :content => "un content"}
    Discussion.find_by_id(d.id).title.should == "newtitle"
    
    last_response.should be_redirect
  end
  
  it 'delete /discussion/:id => delete the discussion that corresponds a the id' do
    d = Discussion.new
    d.title = "title"
    d.content ="tutu"
    d.save

    delete "/discussion/#{d.id}"
    Discussion.find_by_id(d.id).should be_nil
    
    last_response.should be_redirect
  end
  

end


describe "when the asking doesn't exist" do
  it "show error message for get inexisting discussion" do
    d = Discussion.new
    d.title = "Un super titre"
    d.content = "un super contenu"
    d.user_id = 1;
    d.save
    
    id = d.id
    d.destroy
    
    get "/discussion/#{id}"
    last_response.body.should match /<error/
  end
  
  it "show error message for delete inexisting discussion" do
    d = Discussion.new
    d.title = "Un super titre"
    d.content = "un super contenu"
    d.user_id = 1;
    d.save
    
    id = d.id
    d.destroy
    
    delete "/discussion/#{id}"
    last_response.body.should match /<error/
  end
  
  it "show error message for put inexisting discussion" do
    d = Discussion.new
    d.title = "Un super titre"
    d.content = "un super contenu"
    d.user_id = 1;
    d.save
    
    id = d.id
    d.destroy
    
    put "/discussion/#{id}", {:title => "newtitle", :content => "un content"}
    last_response.body.should match /<error/
  end
end