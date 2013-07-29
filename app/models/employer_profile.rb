class EmployerProfile < ActiveRecord::Base
  before_update validate :emailVsOrganisationCheck,  :unless => :skipEmailVsOrganisationCheck
  
  attr_accessible :bio, :name
  attr_accessor :skipEmailVsOrganisationCheck, :user
  
  def emailVsOrganisationCheck
    organisation_name = OrganisationEmailDomain.getOrganisation user.email
    unless name == organisation_name
      errors.add(:name, "<p>The organisation field and the email address you are registering with do not match. Please try agian.</p><p>If this problem continues please contact us via the contact us page.</p>".html_safe)
    end 
  end
  
  
end
