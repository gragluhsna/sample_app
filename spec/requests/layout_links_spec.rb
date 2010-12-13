require 'spec_helper'

describe "LayoutLinks" do
  describe "GET /layout_links" do
    it "should get home page at '/'" do
      get '/'
      response.should have_selector('title' , :content => 'Home')
    end
    
    it "should get about page at '/about'" do
      get '/about'
      response.should have_selector('title' , :content => 'About')
    end
    
    it "should get help page at '/help'" do
      get '/help'
      response.should have_selector('title' , :content => 'Help')
    end
    
    it "should get contact page at '/contact'" do
      get '/contact'
      response.should have_selector('title' , :content => 'Contact')
    end
    
    it "should get signup page at 'signup'" do
      get '/signup'
      response.should have_selector('title' , :content => 'Sign up')
    end

    it "should have the right links on the layout" do
      visit root_path
      click_link "About"
      response.should have_selector("title",:content => "About")
      click_link "Help"
      response.should have_selector("title",:content => "Help")
      click_link "Contact"
      response.should have_selector("title",:content => "Contact")
      click_link "Home"
      response.should have_selector("title",:content => "Home")
      click_link "Sign up now!"
      response.should have_selector("title",:content => "Sign up")
      
    end
    
  end    

  describe "when not signed in" do
    it "should have the sign in link for non logged in version" do
      visit root_path
      response.should have_selector("a" , :href => signin_path , :content => "Sign in")
    end
  
  end

  describe "when signed in" do
    
      before(:each) do
        @user = Factory(:user)
        visit signin_path
        fill_in :email , :with => @user.email
        fill_in :password , :with => @user.password
        click_button
      end
    
      it "should show sign out link" do
        visit root_path
        response.should have_selector("a" , :href => signout_path, :content => "Sign out")
      end
      
      it "should have profile link" do
        visit root_path
        response.should have_selector("a", :href => user_path(@user),:content => "Profile")      
      end
  end
  
end
