require 'spec_helper'

describe Beer do

 describe "valid beer" do
 	s = FactoryGirl.create(:style)
    let(:beer){ Beer.create name:"Koff", :style => s}

    it "is saved" do
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
	end

 describe "without name" do
	let(:beer){ Beer.create }

	it "is not saved" do
		expect(beer).not_to be_valid
		expect(Beer.count).to eq(0)

	end 
end


 describe "without style" do
	let(:beer){ Beer.create name:"Asdkek" }

	it "is not saved" do
		expect(beer).not_to be_valid
		expect(Beer.count).to eq(0)

	end 
end

end
