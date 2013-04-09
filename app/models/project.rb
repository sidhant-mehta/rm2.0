class Project < ActiveRecord::Base
  attr_accessible :closing_date, :description, :draft, :email, :location, :name, :organisation, :project_leader, :sector_ids, :telephone
end
