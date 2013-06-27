class Project < ActiveRecord::Base
  attr_accessible :closing_date, :description, :draft, :email, :location, :name, :organisation, :project_leader, :sector_ids, :telephone


    def self.search (name, sector, closing_date, pay)
      t = Project.arel_table

      if (closing_date.nil?) 
        closing_date = "" #this makes sure it is not nil. so that we can still get the rest of the view code working with .empty?
      end
  
      d, m, y = closing_date.split '-' #need to check if date is valid otherwise tries to perform date operation on invalid input - error.
      if (Date.valid_date? y.to_i, m.to_i, d.to_i)
         
          return Project.where(t[:name].matches("%#{name}%").and((t[:sector_ids].matches("%#{sector}%")))).
                where("closing_date > ?", Date.strptime(closing_date,"%d-%m-%Y"))
      else
          return Project.where(t[:name].matches("%#{name}%").and((t[:sector_ids].matches("%#{sector}%"))))
      end
  
     end
end
