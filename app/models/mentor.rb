class Mentor < ActiveRecord::Base
  attr_accessible :closing_date, :description, :draft, :email, :fname, :image, :lname, :location, :organisation, :role_title, :sector_ids, :telephone

    
  
    def self.search (fname, lname, sector, closing_date)
      t = Mentor.arel_table
debugger      
      return Mentor.where(t[:fname].matches("%#{fname}%").and(t[:lname].matches("%#{lname}%").and((t[:sector_ids].matches("%#{sector}%"))))).
            where("closing_date > ?", Date.strptime(closing_date,"%d-%m-%Y"))

     end
end
