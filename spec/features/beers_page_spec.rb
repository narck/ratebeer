require 'spec_helper'

include OwnTestHelper

describe "Beer" do

  before :each do
      FactoryGirl.create :user
      sign_in(username:"Pekka", password:"Foobar1")
  end
  
  let!(:brewery) {FactoryGirl.create :brewery, name:"Koff"}
  let!(:ses) {FactoryGirl.create(:style2)}

  it "with a valid name should be saved" do
    visit new_beer_path
    fill_in('beer_name', with: "TopKeKBeer")
    select("testikakkonen", :from => "beer[style_id]")
    select('Koff', from:'beer[brewery_id]')
    
      expect{
        click_button("Create Beer")
      }.to change{Beer.count}.from(0).to(1)
    
  end

  it "with invalid name is not saved" do
    visit new_beer_path
    fill_in('beer_name', with: "")
    select('testikakkonen', from:'beer[style_id]')
    select('Koff', from:'beer[brewery_id]')
    
      expect{
        click_button("Create Beer")
      }.not_to change{Beer.count}
  end
end