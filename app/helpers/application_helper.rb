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

  def organisationProfileExists?(org)
    if EmployerProfile.exists?(:name => org)
      return employer_profile_path(EmployerProfile.find_by_name(org))
    else
      return -1
    end
  end

end
