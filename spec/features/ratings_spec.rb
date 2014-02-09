require 'spec_helper'

include OwnTestHelper
describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:b1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:b2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }


  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(b1.ratings.count).to eq(1)
    expect(b1.average_rating).to eq(15.0)
  end


 describe "With many valid ratings" do
    let!(:r1) { FactoryGirl.create :rating, beer: b1, user: user }
    let!(:r2) { FactoryGirl.create :rating, beer: b2, user: user }
    let!(:r3) { FactoryGirl.create :rating, beer: b1, user: user }

    it "shows correct amount of ratings" do
      visit ratings_path

      expect(page).to have_content("Number of ratings 3")
      expect(page).to have_content("Karhu")
      expect(page).to have_content("iso 3")
    end 



  

end
end