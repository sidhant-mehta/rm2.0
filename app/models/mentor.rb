class Mentor < ActiveRecord::Base
  attr_accessible :closing_date, :description, :draft, :email, :fname, :image, :lname, :location, :organisation, :role_title, :sector_ids, :telephone

    
  
    def self.search (fname, lname, sector)
      t = Mentor.arel_table
      
      return Mentor.where(t[:fname].matches("%#{fname}%").and(t[:lname].matches("%#{lname}%").and((t[:sector_ids].matches("%#{sector}%")))))
        

    end
end
