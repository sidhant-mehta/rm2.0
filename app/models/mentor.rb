class Mentor < ActiveRecord::Base
  has_many :member_mentor_applications, :dependent => :destroy
  has_many :members, :through => :member_mentor_applications

  before_create validate :email_check, :unless => :skip_email_check
  before_create validate :organisation_check, :unless => :skip_organisation_check
  before_update validate :email_check, :unless => :skip_email_check
  before_update validate :organisation_check, :unless => :skip_organisation_check
  mount_uploader :image, ImageUploader
  attr_accessible :closing_date, :description, :draft, :email, :fname, :image, :lname, :location, :organisation, :role_title, :sector_ids, :telephone, :internal, :external, :remove_image
  attr_accessor :skip_email_check, :skip_organisation_check, :user

    extend FriendlyId
    friendly_id :fname_and_lname , use: :slugged
 
    def fname_and_lname
        "#{fname} #{lname}"
    end
 

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

    def self.search (fname, lname, sector, location, closing_date)
      t = Mentor.arel_table

      if (closing_date.nil?) 
        closing_date = "" #this makes sure it is not nil. so that we can still get the rest of the view code working with .empty?
      end
  
      d, m, y = closing_date.split '-' #need to check if date is valid otherwise tries to perform date operation on invalid input - error.
      if (Date.valid_date? y.to_i, m.to_i, d.to_i)
         
          return Mentor.where( t[:fname].matches("%#{fname}%").and( t[:lname].matches("%#{lname}%").and( ( t[:sector_ids].matches("%#{sector}%").and(t[:location].matches("%#{location}%") )))) ).
                where("closing_date < ?", Date.strptime(closing_date,"%d-%m-%Y"))
      else
          return Mentor.where( t[:fname].matches("%#{fname}%").and( t[:lname].matches("%#{lname}%").and( ( t[:sector_ids].matches("%#{sector}%").and(t[:location].matches("%#{location}%") )))) )
      end
  
     end

    #VALIDATION 
    EMAIL_REGEX = /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i
    validates_presence_of :fname, :message => "You need to inlcude a first name."
    validates_length_of :fname, :minimum => 2, :maximum => 15, :message => "Your first name must be between 2 and 15 characters."
    validates_format_of :fname, :with => /^[a-z ]+$/i, :message => "First name can only take letters."    

    validates_presence_of :lname, :message => "You must include a last name"
    validates_length_of :lname, :within => 2..15, :message => "Your first name must be between 2 and 15 characters."
    validates_format_of :lname, :with => /^[a-z ]+$/i, :message => "Last name can only take letters."
  
    validates_presence_of :email, :message => "You must include an email"
    validates_length_of :email, :within => 3..50, :message => "Your email can only be between 3 to 50 characters"
    #validates_uniqueness_of :email, :message => "This email address has already been used"
    validates_format_of :email, :with => EMAIL_REGEX, :message => "Please use a valid email address"
    validates_confirmation_of :email
    
    validates_presence_of :closing_date, :message => "Please select a closing date"
    validates_date :closing_date, :on_or_after => lambda { Date.current  }, :on_or_after_message => "Closing date cannot be before today"
    
     validates_presence_of :organisation, :message=> "You must include an organisation."
     validates_format_of :organisation, :with => /^[a-z.'& ]+$/i, :message => "Organisation can contain letters only."
    
    #validates_presence_of :description, :message => "You must include a description/bio for the mentor"
    validates_length_of :description, :maximum => 5000, :message => "You must include a description/bio for the mentor must be at most 5000 characters"
    #validates_format_of :description, :with => /^(?=.*[A-Z0-9 ])+[\w.,;!"'\/$ ]+$/i, :message => "Description can only contain alphanumeric characters" # this regex allows for alphhanumeric and punctuation
    
    validates_presence_of :location, :message => "You must include a location"
    #TODO: add validation to check that the value is present in the location table.
    #TODO: add validation to check the value of sectors
    
    validates_presence_of :role_title, :message => "You must include a role title"
    validates_length_of :role_title, :minimum => 3, :maximum=> 100, :message => "Role title can only be between 3 and 100 characters"
    validates_format_of :role_title, :with => /^[a-z\-& ]+$/i, :message => "Role title can only contain letters"
    
  #  validates_presence_of :telephone, :message => "You must include a telephone number"
   # validates_length_of :telephone, :minimum => 11, :maximum =>11, :message => "Please enter a valid UK telephone number consisting of exactly 11 digits"
    #validates_format_of :telephone, :with => /^[0-9]+$/, :message => "Please enter a valid UK telephone number containing only digits"


end
