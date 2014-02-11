require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi") ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "renders nothing with false query" do
    BeermappingApi.stub(:places_in).with("wew").and_return(
        [ ]
    )

  	c = BeermappingApi.places_in("wew")

    visit places_path
    fill_in('city', with: 'wew')
    click_button "Search"
    expect(c).to eq([])
    expect(page).to have_content "No locations"
  end  

  it "renders correct amount of places" do 
  	BeermappingApi.stub(:places_in).with("helsinki").and_return(
        [ Place.new(:name => "wew", :city => "helsinki"), Place.new(:name => "lad"), Place.new(:name => "kek")]
    )

  	c = BeermappingApi.places_in("helsinki")
    visit places_path
    fill_in('city', with: c.first.send(:city))
    click_button "Search"

    expect(page).to have_content "Total found in #{c.first.send(:city).capitalize}: #{c.count}"
  end 

end	