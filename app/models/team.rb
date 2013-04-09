class Team < ActiveRecord::Base
  attr_accessible :bio, :fname, :image, :lname, :position
end
