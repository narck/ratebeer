class Beer < ActiveRecord::Base
	include RatingAverage

	belongs_to :brewery
	has_many :ratings, dependent: :destroy
	
  	has_many :raters, -> { uniq }, through: :ratings, source: :user
	validates :name, presence: true

	def average_rating
		ratings = self.ratings.select(:score)
		ratings.extend RatingAverage
		return ratings.average_rating(ratings.pluck(:score))
	end

	def to_s
		return "#{name} #{brewery.to_s}"
	end

end
