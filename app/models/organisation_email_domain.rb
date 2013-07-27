class OrganisationEmailDomain < ActiveRecord::Base
  attr_accessible :domain, :organisation

def self.getOrganisation (email)
  dom = self.getDomain (email)  
  org = OrganisationEmailDomain.where(domain: dom )
  
  if org.blank? 
    org = -1
  else
    org = org[0].organisation
  end
  return org
end

def self.getDomain (email)
  return email.split('@')[1]
end

end
