module RatingAverage

def average_rating(list)
	list.inject(0) { |result, element| result + element }
end
end