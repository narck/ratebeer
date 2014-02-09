class User < ActiveRecord::Base
  include RatingAverage

  validates :username, uniqueness: true,
                       length: { in: 3..15 }

  validates :password, length: { minimum: 3 },
                       format: { with: /.*(\d.*[A-Z]|[A-Z].*\d).*/,
                                 message: "should contain a uppercase letter and a number" }


  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

   def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_brewery
    breweries = ratings.group_by {|b| b.beer.send(:brewery)}
    return nil if breweries.empty? # pass nil to avoid breakage
    breweries.max_by{|b, ratings| ratings.map(&:score).inject(0.0, :+) / ratings.size}.first

  end

  def favorite_style
    styles = ratings.group_by {|b| b.beer.send(:style)}
    return nil if styles.empty?
    styles.max_by{|b, ratings| ratings.map(&:score).inject(0.0, :+) / ratings.size}.first

  end
end
