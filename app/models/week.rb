class Week < ActiveRecord::Base
  belongs_to :leagues_per_season

  has_many :matches
end