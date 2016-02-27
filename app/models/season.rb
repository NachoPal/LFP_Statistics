class Season < ActiveRecord::Base
  has_many :leagues_per_seasons
  has_many :leagues, :through => :leagues_per_seasons
end