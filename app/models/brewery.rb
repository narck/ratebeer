class Brewery < ActiveRecord::Base
	include RatingAverage
	has_many :beers, :dependent => :destroy
	has_many :ratings, :through => :beers

	def to_s
		return self.name
	end

	def average_rating
		be = self.beers
		averages = Array.new
		for b in be do 
			if b.average_rating == nil

			else
				averages << b.average_rating
			end
		end

		averages.extend RatingAverage
		return averages.average_rating(averages)


	end

end
