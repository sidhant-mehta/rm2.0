module ApplicationHelper

def getOrganisation (email)
  dom = getDomain (email)  
  org = OrganisationEmailDomain.where(domain: dom )
  
  if org.blank? 
    org = -1
  else
    org = org[0].organisation
  end
  return org
end

def getDomain (email)
  return email.split('@')[1]
end


  def locationHTML(obj)
 
     return Location.find(obj.location).name
  end


end
