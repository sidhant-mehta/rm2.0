class Mentor < ActiveRecord::Base
  attr_accessible :closing_date, :description, :draft, :email, :fname, :image, :lname, :location, :organisation, :role_title, :sector_ids, :telephone
end
