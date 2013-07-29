class String
  def is_number?
    true if Float(self) rescue false
  end
end

class Project < ActiveRecord::Base
  before_create validate :email_check, :unless => :skip_email_check
  before_create validate :organisation_check, :unless => :skip_organisation_check
  before_update validate :email_check, :unless => :skip_email_check
  before_update validate :organisation_check, :unless => :skip_organisation_check
  
  attr_accessible :closing_date, :description, :draft, :email, :location, :name, :organisation, :project_leader, :sector_ids, :telephone, :salary, :internal
  attr_accessor :skip_email_check, :skip_organisation_check, :user
  
  def email_check 
     unless email == user.email
        errors.add(:email, "The email field must be the same as the one you have registered with.")
      end
  end

  def organisation_check 
    org= OrganisationEmailDomain.getOrganisation (user.email) 
      unless organisation ==  org
        errors.add(:organisation, "The organisation field must be the same as the one you have registered with.")
      end
  end

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
     
     
     #VALIDATION
     EMAIL_REGEX = /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i
     
     validates_presence_of :name, :message=> "You must include a project name."
     validates_format_of :name, :with => /^[a-z ]+$/i, :message => "Project name can contian letters only."
     
     validates_presence_of :project_leader, :message=> "You must inlude a project leader."
     validates_format_of :project_leader, :with => /^[a-z ]+$/i, :message => "Project leader can contain letters only."
     
     validates_presence_of :organisation, :message=> "You must inlude an organisation."
     validates_format_of :organisation, :with => /^[a-z ]+$/i, :message => "Organisation can contain letters only."
     #TODO validate value of organisation -> have a method to cross ref the email with org name. 
     
     validates_presence_of :salary, :message => "You must include a salary or write 'Expenses' or 'Voluntary' if applicable."
     validates_length_of :salary, :within => 1..9, :message=> "You must include a salary or write 'Expenses' or 'Voluntary' if applicable."
     
     validates_presence_of :description, :message => "You must include a description."
     validates_length_of :description, :minimum => 3, :maximum => 500, :message => "You must include a description/bio for the mentor of between 3 to 500 characters"
     validates_format_of :description, :with => /^(?=.*[A-Z0-9])[\w.,!"'\/$ ]+$/i, :message => "Description can only contain alphanumeric characters" # this regex allows for alphhanumeric and punctuation

     validates_presence_of :location, :message => "You must include a location"
     #TODO: add validation to check that the value is present in the location table.
     #TODO: add validation to check the value of sectors
    
    validates_presence_of :email, :message => "You must include an email"
    validates_length_of :email, :within => 3..50, :message => "Your email can only be between 3 to 50 characters"
    validates_format_of :email, :with => EMAIL_REGEX, :message => "Please use a valid email address"
    
    validates_date :closing_date, :invalid_date_message => "Please select a closing date"
    validates_date :closing_date, :on_or_after => lambda { Date.current  }, :on_or_after_message => "Closing date cannot be before today"

    validates_presence_of :telephone, :message => "You must include a telephone number"
    validates_length_of :telephone, :minimum => 11, :maximum =>11, :message => "Please enter a valid UK telephone number consisting of exactly 11 digits"
    validates_format_of :telephone, :with => /^[0-9]+$/, :message => "Please enter a valid UK telephone number containing only digits"


end
