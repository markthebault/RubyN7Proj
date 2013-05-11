require_relative 'spec_helper'
require 'user'

describe User do
  subject { User.create(:name => "Marco", :password => "1234", :email => "marco@free.fr") }


#test model
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


#test insert new user
describe "routes" do
  it "post /user/new" do
    user = User.find_by_name("toto")
    if user then user.destroy end
  
    post '/user/new', { :name => "toto", :password => "tutu", :email => "tutu@free.fr" }
      last_response.should be_redirect
      User.find_by_name("toto").should_not be_nil 
      
      last_response.should be_redirect
  end

#test get user new form
  it "get /user/new" do
    get '/user/new'
    last_response.body.should match /<form/
  end
  
#test drop user
  it "delete /user/:id" do
    user = User.find_by_name("toto")
    if user then user.destroy end
  
    user = User.new
    user.name = "toto"
    user.password ="tutu"
    user.email = "gg@ff.fr"
    user.save

    delete "/user/#{user.id}"
    User.find_by_id(user.id).should be_nil
    
    last_response.should be_redirect
  end
 

#test modification of user
  it "put /user/:id" do
    user = User.new
    user.name = "toto"
    user.password ="tutu"
    user.email = "gg@ff.fr"
    user.save

    put "/user/#{user.id}", {:password => "pass", :email => "dd@ff.fr"}
    User.find_by_id(user.id).password.should == "pass"
    
    last_response.should be_redirect
  end
end
