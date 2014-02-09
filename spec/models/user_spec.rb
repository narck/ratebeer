require 'spec_helper'

describe User do
describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)	
  end

        describe "name too short" do
    let(:user){ User.create username:"a", password:"Secret1", password_confirmation:"Secret1" }

    it "is not saved" do
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end
	end

      describe "name too long" do
    let(:user){ User.create username:"lelelelelelelelelelelelelel", password:"Secret1", password_confirmation:"Secret1" }

    it "is saved" do
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end
	end

	describe "password only letters " do
    let(:user){ User.create username:"Pekkis", password:"lelalela", password_confirmation:"lelalela" }

    it "is not saved" do
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end
	end

  describe "with a proper password" do
    let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      rating = Rating.new score:10
      rating2 = Rating.new score:20

      user.ratings << rating
      user.ratings << rating2

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end


    it "has method for determining the favorite_beer" do
    user = FactoryGirl.create(:user)
    user.should respond_to :favorite_beer
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end


    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beer_with_rating(10, user)
      best = create_beer_with_rating(25, user)
      create_beer_with_rating(7, user)

      expect(user.favorite_beer).to eq(best)
    end
  end


  describe "favorite brewery" do
    let(:user){ FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_brewery
    end

    it "does not exist without ratings" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only brewery if only one rating" do
      beer = create_beer_with_rating("1", user)
      brewery = beer.brewery
      expect(user.favorite_brewery).to eq(brewery)
    end

    it "is the one with highest rating if several rated" do

      brewery1 = FactoryGirl.create(:brewery)
      brewery2 = FactoryGirl.create(:brewery, :name => "keks")
  
      b1 = FactoryGirl.create(:beer, :style => "b1", :brewery => brewery1)
      b2 = FactoryGirl.create(:beer, :style => "b2", :brewery => brewery2)
      b3 = FactoryGirl.create(:beer, :style => "b3", :brewery => brewery2)


      FactoryGirl.create(:rating, :score => 5, :beer => b1, :user => user)
      FactoryGirl.create(:rating, :score => 6, :beer => b1, :user => user)
      FactoryGirl.create(:rating, :score => 7, :beer => b2, :user => user)
      FactoryGirl.create(:rating, :score => 20, :beer => b3, :user => user)

      expect(user.favorite_brewery).to eq(brewery2)
    end

  end


  describe "favorite style" do
    let(:user){ FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_style
    end

    it "does not exist without ratings" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only style if only one rating" do
      beer = create_beer_with_rating("1", user)
      style = beer.style
      expect(user.favorite_style).to eq(style)
    end

    it "is the one with highest rating if several rated" do

      b1 = FactoryGirl.create(:beer, :style => "b1")
      b2 = FactoryGirl.create(:beer, :style => "b2")
      b3 = FactoryGirl.create(:beer, :style => "b3")

      FactoryGirl.create(:rating, :score => 5, :beer => b1, :user => user)
      FactoryGirl.create(:rating, :score => 6, :beer => b1, :user => user)
      FactoryGirl.create(:rating, :score => 7, :beer => b2, :user => user)
      FactoryGirl.create(:rating, :score => 20, :beer => b3, :user => user)

      expect(user.favorite_style).to eq(b3.style)
    end

  end

    def create_beer_with_rating(score, user)
      beer = FactoryGirl.create(:beer)
      FactoryGirl.create(:rating, score:score, beer:beer, user:user)
      beer
    end

    def create_beers_with_ratings(*scores, user)
    scores.each do |score|
    create_beer_with_rating(score, user)
  end
end
end