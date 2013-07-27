module MembersHelper

def isMentor? (email)
  m = Mentor.find_by_email (email)
  return !m.nil?
end

def internalMentors? (email)
  org = OrganisationEmailDomain.getOrganisation (email)
  if !org.blank?
    m = Mentor.where(:organisation => org, :internal => true)
  else
    m = blank
  end
  
  return !m.blank?
end

end
