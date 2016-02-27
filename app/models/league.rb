class League < ActiveRecord::Base
  has_many :leagues_per_seasons
  has_many :seasons, :through => :leagues_per_seasons
end
