class Advert < ActiveRecord::Base
  attr_accessible :image, :name, :sector_ids
end
