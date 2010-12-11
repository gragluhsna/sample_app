require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_selector("title",:content => "Sign up")
    end
  end

  # describe "GET 'show' user" do
  #   it "should be successful" do
  #     get 'users/1'
  #     response.should have_selector("span",:content=> "Anshul Garg")
  #   end
  # end

end
