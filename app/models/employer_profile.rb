class EmployerProfile < ActiveRecord::Base
  before_update validate :emailVsOrganisationCheck,  :unless => :skipEmailVsOrganisationCheck
  mount_uploader :image, ImageUploader
  attr_accessible :bio, :name, :image, :remove_image, :sector_ids, :location
  attr_accessor :skipEmailVsOrganisationCheck, :user
  
  extend FriendlyId
  friendly_id :name
  
  def emailVsOrganisationCheck
    organisation_name = OrganisationEmailDomain.getOrganisation user.email
    unless name == organisation_name
      errors.add(:name, "<p>The organisation field and the email address you are registering with do not match. Please try agian.</p><p>If this problem continues please contact us via the contact us page.</p>".html_safe)
    end 
  end
  
  def self.search (name, sector_ids, location)
     t = Project.arel_table
    
      result = EmployerProfile.where("name like ?", "%#{name}%")
                                    .where("sector_ids like ?", "%#{sector_ids}%")
                                          .where("location like ?", "%#{location}%")
                                   
      return result
  end
  
  validates_format_of :bio, :with => /^(?=.*[A-Z0-9])[\w.,!"'\/$ ]+$/i, :message => "The company bio/description can only take alpha numeric characters"
  validates_length_of :bio, :maximum => 500, :message => "The company bio/description can only have 500 characters"
  
  validates_presence_of :name, :message => "You must include an organisation name"
  validates_format_of :name, :with => /^[a-z ]+$/i, :message => "The organisation name can only contain letters"
end
