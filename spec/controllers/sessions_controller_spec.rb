require 'spec_helper'

describe SessionsController do
  render_views
  
  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector( "title" , :content => "Sign in" )
    end 
  end

  describe "POST 'create'" do
  
    describe "invalid signin" do
      
      before(:each) do
        @attr = { :email => "foo@bar.com", :password => "password" }
      end
      
      it "should re-render new page" do
        post :create, :session => @attr
        response.should render_template('new')
      end

      it "should display right title" do
        post :create, :session => @attr
        response.should have_selector( "title" , :content => "Sign in" )
      end
      
      it "should flash invalid login message" do
        post :create, :session => @attr
        flash.now[:error].should =~ /invalid/i
      end
      
    end
    
    describe "valid signin" do
    
      before(:each) do
        @user = Factory(:user)
        @attr = { :email => @user.email , :password => @user.password }
      end
      
      it "should signin successfully" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in
      end
    
      it "should redirect to user" do
        post :create, :session => @attr
        response.should redirect_to( user_path(@user) )
      end
    
    end
    
    describe "signout" do
    
      it "should successfully signout" do
        test_sign_in(Factory(:user))
        delete :destroy
        controller.should_not be_signed_in
        response.should redirect_to(root_path)
      end

    end

  end
end
