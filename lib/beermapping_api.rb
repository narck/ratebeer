class BeermappingApi

	def self.find_place(place_id, session)

    places = places_in session[:city]
    placef = nil
    places.each do |p|
      if p.send(:id)==place_id
        placef=p
        print "LEL"
      end
    end

    @place = placef
    
  end

  def self.places_in(city)
		city = city.downcase
		Rails.cache.fetch(city, :expires_in => 1.week) { self.fetch_places_in(city) }
	end

  def find_place(place_id)
  end

	
private

  def self.fetch_places_in(city)
    url = "http://stark-oasis-9187.herokuapp.com/api/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end

  def self.key
    #nope
  end
end