require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { 
      :name => "Anshul Garg", 
      :email => "anshul.garg@gmail.com" , 
      :password => "password" , 
      :password_confirmation => "password" 
      }
  end
  
  it "should create user" do
    User.create!(@attr)
  end
  
  it "should require a name" do
    user_with_no_name = User.new( @attr.merge( :name => "" ) )
    user_with_no_name.should_not be_valid 
  end
  
  it "should require a email address" do
    user_with_no_email = User.new( @attr.merge( :email => "" ) )
    user_with_no_email.should_not be_valid
  end
  
  it "should required name to be less than 50 characters" do
    long_name = "a" * 51
    long_name_user = User.new( @attr.merge(  :name =>  long_name ) )
    long_name_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[abrd@abccomc.com abrdsaasd@bcg.com abc@gmail.com abcf@ggma.com]
    addresses.each do |address|
      user_with_valid_email = User.new( @attr.merge(:email => address ))
      user_with_valid_email.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[abrd@abccom abrdsaasd .1abcgmail.com abcf.com]
    addresses.each do |address|
      user_with_invalid_email = User.new( @attr.merge(:email => address ))
      user_with_invalid_email.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email identical to up case" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr.merge( :email => @attr[:email].upcase ))
    user_with_duplicate_email.should_not be_valid
    
  end
  
  describe "password validation" do
  it "should require a password" do
    User.new(@attr.merge( :password => "" , :password_confirmation => "")).
    should_not be_valid
  end
  
  it "should reject password less than 6 chars" do
    short = "a"*5
    User.new(@attr.merge(:password => short, :password_confirmation => short )).
    should_not be_valid
  end
  
  it "should reject long password" do
    long = "a"*41
    User.new(@attr.merge(:password => long, :password_confirmation => long )).
    should_not be_valid
  end
  
  it "should match with confirm password" do
    User.new(@attr.merge(:password_confirmation => "invalid")).
    should_not be_valid
  end
end

describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
  end
  
describe "check password" do
  
  it "should return false for wrong password" do
    User.create!(@attr).has_password?("password1").should be_false
  end
  
  it "should return true for correct password" do
    User.create!(@attr).has_password?(@attr[:password]).should be_true
  end
  
end
  

end


