require 'spec_helper'
include OwnTestHelper

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end
  end



    it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  describe "who has signed up" do
    # ...

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"lel")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'username and password do not match'
    end

    it "can delete his own ratings successfully" do
      sign_in(username:"Pekka", password:"Foobar1")
      user = User.first
      beer1 = FactoryGirl.create :beer
      user.ratings << (FactoryGirl.create :rating, beer: beer1, score: 15, user: user)
      visit user_path(user) 

      expect { 
        click_link('delete')
      }.to change{Rating.count}.from(1).to(0)
    end
    
  end
end
  describe "User's page" do

    let!(:user) {FactoryGirl.create :user, username: "Keka"}    
    let!(:b1) {FactoryGirl.create :beer}
    let!(:b2) {FactoryGirl.create :beer}
    let!(:b3) {FactoryGirl.create :beer2, :brewery => FactoryGirl.create(:brewery, :name => "keks")} 

    let!(:r1) {FactoryGirl.create :rating, beer: b1, score: 5, user: user}
    let!(:r2) {FactoryGirl.create :rating, beer: b2, score: 6, user: user}
    let!(:r3) {FactoryGirl.create :rating, beer: b3, score: 44, user: user}


    it "has only all ratings by him" do
      visit user_path(user)

      expect(page).to have_content("has made " + user.ratings.count.to_s + " ratings")
      expect(page).to have_content("#{b1.name} 5")
      expect(page).to have_content("#{b2.name} 6")
    end

    it "shows user's favorite style correctly" do
      visit user_path(user)
      expect(page).to have_content("Favorite style: #{b3.style.name}")
    end

    it "shows user's favorite brewery correctly" do 
      visit user_path(user)
      expect(page).to have_content("Favorite brewery: #{b3.brewery.name}")
    end

end

