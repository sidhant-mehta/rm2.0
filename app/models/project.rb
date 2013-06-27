class String
  def is_number?
    true if Float(self) rescue false
  end
end

class Project < ActiveRecord::Base
  attr_accessible :closing_date, :description, :draft, :email, :location, :name, :organisation, :project_leader, :sector_ids, :telephone, :salary

#TODO add validation - general - salary


    def self.search (name, sector, closing_date, salary)
      t = Project.arel_table

      if (closing_date.nil?) 
        closing_date = "" #this makes sure it is not nil. so that we can still get the rest of the view code working with .empty?
      end
  
      d, m, y = closing_date.split '-' #need to check if date is valid otherwise tries to perform date operation on invalid input - error.
      if (Date.valid_date? y.to_i, m.to_i, d.to_i)
         
          result = Project.where(t[:name].matches("%#{name}%").and((t[:sector_ids].matches("%#{sector}%")))).
                where("closing_date > ?", Date.strptime(closing_date,"%d-%m-%Y"))
      else
          result = Project.where(t[:name].matches("%#{name}%").and((t[:sector_ids].matches("%#{sector}%"))))
      end
      
      if (!salary.nil? and salary.is_number? ==true) #if it is a number then you need to add another condition to have salary at least that much. If it is not a number (so "Expenses") then you can include all results hence no need to add a condition. If someone enteres another non-number except for "Expenses" same idea applies (it is not a number so show all)
          result = result.where("salary <> ? and salary > ?", "Expenses", salary) #needed to add the <> condition because with just > it still shows the "Expenses" results
      end
        
      return result
        
     end
end
