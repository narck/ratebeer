class Membership < ActiveRecord::Base

	belongs_to :user
	belongs_to :beerclubs
	validates_uniqueness_of :user_id, :scope => :beer_club_id, :message => "is already a member of this club!"

def to_s
	"#{name}"
end

end
