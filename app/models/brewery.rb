class Brewery < ActiveRecord::Base
	include RatingAverage
	has_many :beers, :dependent => :destroy
	has_many :ratings, :through => :beers


	
	validates :name, presence: true
	validates :year, numericality: { greater_than_or_equal_to: 1024,
										only_integer: true }

  validates :year, :inclusion => { :in => proc { 104..Time.now.year }, :message => "cannot be in the future!" }
	def to_s
		return self.name
	end

	def print_report
	    puts name
	    puts "established at year #{year}"
	    puts "number of beers #{beers.count}"
	    puts "number of ratings #{ratings.count}"
	end

	def restart
	    @self.year = 2014
	    puts "changed year to #{@year}"
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

	def validates_year_not_in_the_future 
    	if year.present? && year > Time.now.year
      		errors.add(:expiration_date, "can't be in the future")
    end

  	end

end
