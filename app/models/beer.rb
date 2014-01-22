class Beer < ActiveRecord::Base
	include RatingAverage

	belongs_to :brewery
	has_many :ratings


	def average_rating
		ratings = self.ratings.select(:score)
		ratings.extend RatingAverage
		return ratings.average_rating(ratings.pluck(:score))
	end

	def to_s
		
		return self.name + ', ' + brewery.to_s
	end

end
