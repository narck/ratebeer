class User < ActiveRecord::Base
	include RatingAverage

	has_secure_password
	validates :username, uniqueness: true, 
							length: { minimum: 3, maximum: 15 }
	validates :password, :presence => true,
                   :confirmation => true,
                   :length => {:minimum => 4}

    validates :password, :format => {:with => /(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+/, :message => "must contain at least one number and one uppercase letter" }

	has_many :ratings, :dependent => :destroy
	has_many :beers, through: :ratings

	has_many :memberships, :dependent => :destroy



	def average_rating
		ratings = self.ratings.select(:score)
		ratings.extend RatingAverage
		return ratings.average_rating(ratings.pluck(:score))
	end

end
